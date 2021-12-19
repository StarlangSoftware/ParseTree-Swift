//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 6.04.2021.
//

import Foundation
import Dictionary

public class ParseNode{
    
    public var children: [ParseNode]? = nil
    public var parent: ParseNode? = nil
    public var data: Symbol? = nil
    
    private static var ADJP : [String] = ["NNS", "QP", "NN", "$", "ADVP", "JJ", "VBN", "VBG", "ADJP", "JJR", "NP", "JJS", "DT", "FW", "RBR", "RBS", "SBAR", "RB"]
    private static var ADVP : [String] = ["RB", "RBR", "RBS", "FW", "ADVP", "TO", "CD", "JJR", "JJ", "IN", "NP", "JJS", "NN"]
    private static var CONJP : [String] = ["CC", "RB", "IN"]
    private static var FRAG : [String] = []
    private static var INTJ : [String] = []
    private static var LST : [String] = ["LS", ":"]
    private static var NAC : [String] = ["NN", "NNS", "NNP", "NNPS", "NP", "NAC", "EX", "$", "CD", "QP", "PRP", "VBG", "JJ", "JJS", "JJR", "ADJP", "FW"]
    private static var PP : [String] = ["IN", "TO", "VBG", "VBN", "RP", "FW"]
    private static var PRN : [String] = []
    private static var PRT : [String] = ["RP"]
    private static var QP : [String] = ["$", "IN", "NNS", "NN", "JJ", "RB", "DT", "CD", "NCD", "QP", "JJR", "JJS"]
    private static var RRC : [String] = ["VP", "NP", "ADVP", "ADJP", "PP"]
    private static var S : [String] = ["TO", "IN", "VP", "S", "SBAR", "ADJP", "UCP", "NP"]
    private static var SBAR : [String] = ["WHNP", "WHPP", "WHADVP", "WHADJP", "IN", "DT", "S", "SQ", "SINV", "SBAR", "FRAG"]
    private static var SBARQ : [String] = ["SQ", "S", "SINV", "SBARQ", "FRAG"]
    private static var SINV : [String] = ["VBZ", "VBD", "VBP", "VB", "MD", "VP", "S", "SINV", "ADJP", "NP"]
    private static var SQ : [String] = ["VBZ", "VBD", "VBP", "VB", "MD", "VP", "SQ"]
    private static var UCP : [String] = []
    private static var VP : [String] = ["TO", "VBD", "VBN", "MD", "VBZ", "VB", "VBG", "VBP", "VP", "ADJP", "NN", "NNS", "NP"]
    private static var WHADJP : [String] = ["CC", "WRB", "JJ", "ADJP"]
    private static var WHADVP : [String] = ["CC", "WRB"]
    private static var WHNP : [String] = ["WDT", "WP", "WP$", "WHADJP", "WHPP", "WHNP"]
    private static var WHPP : [String] = ["IN", "TO", "FW"]
    private static var NP1 : [String] = ["NN", "NNP", "NNPS", "NNS", "NX", "POS", "JJR"]
    private static var NP2 : [String] = ["NP"]
    private static var NP3 : [String] = ["$", "ADJP", "PRN"]
    private static var NP4 : [String] = ["CD"]
    private static var NP5 : [String] = ["JJ" , "JJS", "RB", "QP"]
    
    /**
     * Empty constructor for ParseNode class.
     */
    public init(){
    }

    /**
     * Constructs a ParseNode from a single line. If the node is a leaf node, it only sets the data. Otherwise, splits
     * the line w.r.t. spaces and paranthesis and calls itself resursively to generate its child parseNodes.
     - Parameters:
        - parent: The parent node of this node.
        - line: The input line to create this parseNode.
        - isLeaf: True, if this node is a leaf node false otherwise.
     */
    public init(parent: ParseNode?, line: String, isLeaf: Bool){
        var parenthesisCount : Int = 0
        var childLine : String = ""
        self.parent = parent
        children = []
        if isLeaf {
            data = Symbol(name: line)
        } else {
            data = Symbol(name: String(line[line.index(line.startIndex, offsetBy: 1)..<line.range(of: " ")!.lowerBound]))
            if line.firstIndex(of: ")") == line.lastIndex(of: ")") {
                let start = line.index(line.firstIndex(of: " ")!, offsetBy: 1)
                let end = line.firstIndex(of: ")")!
                children!.append(ParseNode(parent: self, line: String(line[start..<end]), isLeaf: true))
            } else {
                let emptyIndex = Int(line.distance(from: line.startIndex, to: line.firstIndex(of: " ")!))
                for i in emptyIndex + 1..<line.count {
                    if Word.charAt(s: line, i: i) != " " || parenthesisCount > 0 {
                        childLine = childLine + String(Word.charAt(s: line, i: i))
                    }
                    if Word.charAt(s: line, i: i) == "(" {
                        parenthesisCount += 1
                    } else {
                        if Word.charAt(s: line, i: i) == ")" {
                            parenthesisCount -= 1
                        }
                    }
                    if parenthesisCount == 0 && childLine != "" {
                        children!.append(ParseNode(parent: self, line: childLine.trimmingCharacters(in: .whitespacesAndNewlines), isLeaf: false))
                        childLine = ""
                    }
                }
            }
        }
    }
    
    /**
     * Another simple constructor for ParseNode. It takes inputs left and right children of this node, and the data.
     * Sets the corresponding attributes with these inputs.
     - Parameters:
        - left: Left child of this node.
        - right: Right child of this node.
        - data: Data for this node.
     */
    public init(left: ParseNode, right: ParseNode, data: Symbol){
        children = []
        children!.append(left)
        left.parent = self
        children!.append(right)
        right.parent = self
        self.data = data
    }
    
    /**
     * Another simple constructor for ParseNode. It takes inputs left child of this node and the data.
     * Sets the corresponding attributes with these inputs.
     - Parameters:
        - left: Left child of this node.
        - data: Data for this node.
     */
    public init(left: ParseNode, data: Symbol){
        children = []
        children!.append(left)
        left.parent = self
        self.data = data
    }
    
    /**
     * Another simple constructor for ParseNode. It only take input the data, and sets it.
     - Parameters:
        - data: Data for this node.
     */
    public init(data: Symbol){
        children = []
        self.data = data
    }
    
    /**
     * Extracts the head of the children of this current node.
    - Parameters:
        - priorityList: Depending on the pos of current node, the priorities among the children are given with this parameter
        - direction: Depending on the pos of the current node, search direction is either from left to right, or from
     *                  right to left.
        - defaultCase: If true, and no child appears in the priority list, returns first child on the left, or first
     *                    child on the right depending on the search direction.
     - Returns: Head node of the children of the current node
     */
    private func searchHeadChild(priorityList: [String], direction: SearchDirectionType, defaultCase: Bool) -> ParseNode?{
        switch direction{
            case SearchDirectionType.LEFT:
                for item in priorityList {
                    for child in children! {
                        if child.getData()!.trimSymbol().getName() == item {
                            return child
                        }
                    }
                }
                if defaultCase {
                    return firstChild()
                }
            case SearchDirectionType.RIGHT:
                for item in priorityList {
                    var j : Int = children!.count - 1
                    while j >= 0 {
                        let child = children![j]
                        if child.getData()!.trimSymbol().getName() == item {
                            return child
                        }
                        j -= 1
                    }
                }
                if defaultCase {
                    return lastChild()
                }
        }
        return nil
    }
    
    /**
     * If current node is not a leaf, it has one or more children, this method determines recursively the head of
     * that (those) child(ren). Otherwise, it returns itself. In this way, this method returns the head of all leaf
     * successors.
     - Returns: Head node of the descendant leaves of this current node.
     */
    public func headLeaf() -> ParseNode?{
        if children!.count > 0 {
            let head = headChild()
            if head != nil {
                return head!.headLeaf()
            } else {
                return nil
            }
        } else {
            return self
        }
    }
    
    /**
     * Calls searchHeadChild to determine the head node of all children of this current node. The search direction and
     * the search priority list is determined according to the symbol in this current parent node.
     - Returns: Head node among its children of this current node.
     */
    public func headChild() -> ParseNode?{
        var result : ParseNode? = nil
        switch data!.trimSymbol().description() {
            case "ADJP":
                return searchHeadChild(priorityList: ParseNode.ADJP, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "ADVP":
                return searchHeadChild(priorityList: ParseNode.ADVP, direction: SearchDirectionType.RIGHT, defaultCase: true)
            case "CONJP":
                return searchHeadChild(priorityList: ParseNode.CONJP, direction: SearchDirectionType.RIGHT, defaultCase: true)
            case "FRAG":
                return searchHeadChild(priorityList: ParseNode.FRAG, direction: SearchDirectionType.RIGHT, defaultCase: true)
            case "INTJ":
                return searchHeadChild(priorityList: ParseNode.INTJ, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "LST":
                return searchHeadChild(priorityList: ParseNode.LST, direction: SearchDirectionType.RIGHT, defaultCase: true)
            case "NAC":
                return searchHeadChild(priorityList: ParseNode.NAC, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "PP":
                return searchHeadChild(priorityList: ParseNode.PP, direction: SearchDirectionType.RIGHT, defaultCase: true)
            case "PRN":
                return searchHeadChild(priorityList: ParseNode.PRN, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "PRT":
                return searchHeadChild(priorityList: ParseNode.PRT, direction: SearchDirectionType.RIGHT, defaultCase: true)
            case "QP":
                return searchHeadChild(priorityList: ParseNode.QP, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "RRC":
                return searchHeadChild(priorityList: ParseNode.RRC, direction: SearchDirectionType.RIGHT, defaultCase: true)
            case "S":
                return searchHeadChild(priorityList: ParseNode.S, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "SBAR":
                return searchHeadChild(priorityList: ParseNode.SBAR, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "SBARQ":
                return searchHeadChild(priorityList: ParseNode.SBARQ, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "SINV":
                return searchHeadChild(priorityList: ParseNode.SINV, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "SQ":
                return searchHeadChild(priorityList: ParseNode.SQ, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "UCP":
                return searchHeadChild(priorityList: ParseNode.UCP, direction: SearchDirectionType.RIGHT, defaultCase: true)
            case "VP":
                return searchHeadChild(priorityList: ParseNode.VP, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "WHADJP":
                return searchHeadChild(priorityList: ParseNode.WHADJP, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "WHADVP":
                return searchHeadChild(priorityList: ParseNode.WHADVP, direction: SearchDirectionType.RIGHT, defaultCase: true)
            case "WHNP":
                return searchHeadChild(priorityList: ParseNode.WHNP, direction: SearchDirectionType.LEFT, defaultCase: true)
            case "WHPP":
                return searchHeadChild(priorityList: ParseNode.WHPP, direction: SearchDirectionType.RIGHT, defaultCase: true)
            case "NP":
                if lastChild().getData()!.getName() == "POS"{
                    return lastChild()
                } else {
                    result = searchHeadChild(priorityList: ParseNode.NP1, direction: SearchDirectionType.RIGHT, defaultCase: false)
                    if (result != nil){
                        return result
                    } else {
                        result = searchHeadChild(priorityList: ParseNode.NP2, direction: SearchDirectionType.LEFT, defaultCase: false)
                        if (result != nil){
                            return result
                        } else {
                            result = searchHeadChild(priorityList: ParseNode.NP3, direction: SearchDirectionType.RIGHT, defaultCase: false)
                            if (result != nil){
                                return result
                            } else {
                                result = searchHeadChild(priorityList: ParseNode.NP4, direction: SearchDirectionType.RIGHT, defaultCase: false)
                                if (result != nil){
                                    return result
                                } else {
                                    result = searchHeadChild(priorityList: ParseNode.NP5, direction: SearchDirectionType.RIGHT, defaultCase: false)
                                    if (result != nil){
                                        return  result
                                    } else {
                                        return lastChild()
                                    }
                                }
                            }
                        }
                    }
                }
            default:
                break
        }
        return nil
    }
    
    /**
     * Adds a child node at the end of the children node list.
     - Parameters:
        - child Child node to be added.
     */
    public func addChild(child: ParseNode){
        children?.append(child)
        child.parent = self
    }
    
    /**
     * Recursive method to restore the parents of all nodes below this node in the hierarchy.
     */
    public func correctParents(){
        for child in children!{
            child.parent = self
            child.correctParents()
        }
    }
    
    /**
     * Adds a child node at the given specific index in the children node list.
     - Parameters:
        - index: Index where the new child node will be added.
        - child: Child node to be added.
     */
    public func addChild(index: Int, child: ParseNode){
        children?.insert(child, at: index)
        child.parent = self
    }
    
    /**
     * Replaces a child node at the given specific with a new child node.
     - Parameters:
        - index: Index where the new child node replaces the old one.
        - child: Child node to be replaced.
     */
    public func setChild(index: Int, child: ParseNode){
        children?[index] = child
    }
    
    /**
     * Removes a given child from children node list.
     - Parameters:
        - child: Child node to be deleted.
     */
    public func removeChild(child: ParseNode){
        for i in 0..<children!.count{
            if children?[i] === child{
                children?.remove(at: i)
                break
            }
        }
    }
    
    /**
     * Recursive method to calculate the number of all leaf nodes in the subtree rooted with this current node.
     - Returns: Number of all leaf nodes in the current subtree.
     */
    public func leafCount() -> Int{
        if children!.count == 0{
            return 1
        } else {
            var sum : Int = 0
            for child in children!{
                sum += child.leafCount()
            }
            return sum
        }
    }
    
    /**
     * Recursive method to calculate the number of all nodes in the subtree rooted with this current node.
     - Returns: Number of all nodes in the current subtree.
     */
    public func nodeCount() -> Int{
        if children!.count > 0{
            var sum : Int = 1
            for child in children!{
                sum += child.nodeCount()
            }
            return sum
        } else {
            return 1
        }
    }
    
    /**
     * Recursive method to calculate the number of all nodes, which have more than one children, in the subtree rooted
     * with this current node.
     - Returns: Number of all nodes, which have more than one children, in the current subtree.
     */
    public func nodeCountWithMultipleChildren() -> Int{
        if children!.count > 1{
            var sum : Int = 1
            for child in children!{
                sum += child.nodeCountWithMultipleChildren()
            }
            return sum
        } else {
            return 0
        }
    }
    
    /**
     * Recursive method to remove all punctuation nodes from the current subtree.
     */
    public func stripPunctuation(){
        children!.removeAll() {Word.isPunctuationSymbol(surfaceForm: $0.getData()!.getName())}
        for child in children!{
            child.stripPunctuation()
        }
    }
    
    /**
     * Returns number of children of this node.
     - Returns: Number of children of this node.
     */
    public func numberOfChildren() -> Int{
        return children!.count
    }
    
    /**
     * Returns the i'th child of this node.
     - Parameters:
        - i: Index of the retrieved node.
     - Returns: i'th child of this node.
     */
    public func getChild(i: Int) -> ParseNode{
        return children![i]
    }
    
    /**
     * Returns the first child of this node.
     - Returns: First child of this node.
     */
    public func firstChild() -> ParseNode{
        return children!.first!
    }
    
    /**
     * Returns the last child of this node.
     - Returns: Last child of this node.
     */
    public func lastChild() -> ParseNode{
        return children!.last!
    }
    
    /**
     * Checks if the given node is the last child of this node.
     - Parameters:
        - child: To be checked node.
     - Returns: True, if child is the last child of this node, false otherwise.
     */
    public func isLastChild(child: ParseNode) -> Bool{
        return lastChild() === child
    }
    
    /**
     * Returns the index of the given child of this node.
     - Parameters:
        - child Child whose index shoud be returned.
     - Returns: Index of the child of this node.
     */
    public func getChildIndex(child: ParseNode) -> Int{
        var index: Int = 0
        for child1 in children!{
            if child1 === child{
                return index
            }
            index += 1
        }
        return -1
    }
    
    /**
     * Returns true if the given node is a descendant of this node.
     - Parameters:
        - node: Node to check if it is descendant of this node.
     - Returns: True if the given node is descendant of this node.
     */
    public func isDescendant(node: ParseNode) -> Bool{
        for child in children!{
            if child === node{
                return true
            } else {
                if child.isDescendant(node: node){
                    return true
                }
            }
        }
        return false
    }
    
    /**
     * Returns the previous sibling (sister) of this node.
     - Returns: If this is the first child of its parent, returns null. Otherwise, returns the previous sibling of this
     * node.
     */
    public func previousSibling() -> ParseNode?{
        for i in 1..<parent!.children!.count{
            if parent?.children![i] === self{
                return parent?.children![i - 1]
            }
        }
        return nil
    }

    /**
     * Returns the next sibling (sister) of this node.
     - Returns: If this is the last child of its parent, returns null. Otherwise, returns the next sibling of this
     * node.
     */
    public func nextSibling() -> ParseNode?{
        for i in 0..<parent!.children!.count - 1{
            if parent?.children![i] === self{
                return parent?.children![i + 1]
            }
        }
        return nil
    }
    
    /**
     * Accessor for the parent attribute.
     - Returns: Parent of this node.
     */
    public func getParent() -> ParseNode?{
        return parent
    }
    
    /**
     * Accessor for the data attribute.
     - Returns: Data of this node.
     */
    public func getData() -> Symbol?{
        return data
    }

    /**
     * Mutator of the data attribute.
     - Parameters:
        - data: Data to be set.
     */
    public func setData(data: Symbol){
        self.data = data
    }
    
    /**
     * Construct recursively the constituent span list of a subtree rooted at this node.
     - Parameters:
        - startIndex: Start index of the leftmost leaf node of this subtree.
        - list: Returned span list.
     */
    public func constituentSpanList(startIndex: Int, list: inout [ConstituentSpan]){
        if children!.count > 0 {
            list.append(ConstituentSpan(constituent: data!, start: startIndex, end: startIndex + leafCount()))
        }
        var total : Int = 0
        for parseNode in children! {
            parseNode.constituentSpanList(startIndex: startIndex + total, list: &list)
            total += parseNode.leafCount()
        }
    }
    /**
     * Returns true if this node is leaf, false otherwise.
     - Returns: true if this node is leaf, false otherwise.
     */
    public func isLeaf() -> Bool{
        return children!.count == 0
    }
    
    /**
     * Returns true if this node does not contain a meaningful data, false otherwise.
     - Returns: true if this node does not contain a meaningful data, false otherwise.
     */
    public func isDummyNode() -> Bool{
        return getData()!.getName().contains("*") || (getData()!.getName() == "0" && parent!.getData()!.getName() == "-NONE-")
    }
    
    /**
     * Recursive function to convert the subtree rooted at this node to a sentence.
     - Returns: A sentence which contains all words in the subtree rooted at this node.
     */
    public func toSentence() -> String{
        if children!.count == 0 {
            if getData() != nil && !isDummyNode() {
                return " " + getData()!.getName().replacingOccurrences(of: "-LRB-", with: "(").replacingOccurrences(of: "-RRB-", with: ")").replacingOccurrences(of: "-LSB-", with: "[").replacingOccurrences(of: "-RSB-", with: "]").replacingOccurrences(of: "-LCB-", with: "{").replacingOccurrences(of: "-RCB-", with: "}").replacingOccurrences(of: "-lrb-", with: "(").replacingOccurrences(of: "-rrb-", with: ")").replacingOccurrences(of: "-lsb-", with: "[").replacingOccurrences(of: "-rsb-", with: "]").replacingOccurrences(of: "-lcb-", with: "{").replacingOccurrences(of: "-rcb-", with: "}")
            } else {
                if (isDummyNode()){
                    return ""
                } else {
                    return " "
                }
            }
        } else {
            var st : String = ""
            for aChild in children! {
                st = st + aChild.toSentence()
            }
            return st
        }
    }
    
    /**
     * Recursive function to convert the subtree rooted at this node to a string.
     - Returns: A string which contains all words in the subtree rooted at this node.
     */
    public func description() -> String{
        if children!.count < 2 {
            if children!.count < 1 {
                return getData()!.getName()
            } else {
                return "(" + data!.getName() + " " + firstChild().description() + ")"
            }
        } else {
            var st : String = "(" + data!.getName()
            for aChild in children! {
                st = st + " " + aChild.description()
            }
            return st + ") "
        }
    }
    
    /**
     * Recursive function to concatenate the data of the all ascendant nodes of this node to a string.
     - Returns: A string which contains all data of all the ascendant nodes of this node.
     */
    public func ancestorString() -> String{
        if parent == nil{
            return (data?.getName())!
        } else {
            return (parent?.ancestorString())! + (data?.getName())!
        }
    }
    
    /**
     * Swaps the given child node of this node with the previous sibling of that given node. If the given node is the
     * leftmost child, it swaps with the last node.
     - Parameters:
        - node: Node to be swapped.
     */
    public func moveLeft(node: ParseNode){
        for i in 0..<children!.count {
            if children?[i] === node {
                if i == 0 {
                    children!.swapAt(0, children!.count - 1)
                } else {
                    children!.swapAt(i, (i - 1) % children!.count)
                }
                return
            }
        }
        for aChild in children! {
            aChild.moveLeft(node: node)
        }
    }
    
    /**
     * Swaps the given child node of this node with the next sibling of that given node. If the given node is the
     * rightmost child, it swaps with the first node.
     - Parameters:
        - node: Node to be swapped.
     */
    public func moveRight(node: ParseNode){
        for i in 0..<children!.count {
            if children?[i] === node {
                if i == children!.count - 1{
                    children!.swapAt(0, children!.count - 1)
                } else {
                    children!.swapAt(i, (i + 1) % children!.count)
                }
                return
            }
        }
        for aChild in children! {
            aChild.moveRight(node: node)
        }
    }
}
