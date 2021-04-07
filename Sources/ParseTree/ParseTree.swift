//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 7.04.2021.
//

import Foundation

public class ParseTree{
    
    private static var sentenceLabels : [String] = ["SINV", "SBARQ", "SBAR", "SQ", "S"]
    public var root: ParseNode? = nil
    
    /**
     * Empty constructor for ParseTree. Initializes the root node to null.
     */
    public init(){
    }
    
    /**
     * Basic constructor for a ParseTree. Initializes the root node with the input.
     - Parameters:
        - root: Root node of the tree
     */
    public init(root: ParseNode){
        self.root = root
    }
    
    /**
     * Another constructor of the ParseTree. The method takes the file containing a single line as input and constructs
     * the whole tree by calling the ParseNode constructor recursively.
     - Parameters:
        - file: File containing a single line for a ParseTree
     */
    public init(url: URL){
        do{
            let fileContent = try String(contentsOf: url, encoding: .utf8)
            let lines : [String] = fileContent.split(whereSeparator: \.isNewline).map(String.init)
            let line = lines[0]
            if line.contains("(") && line.contains(")") {
                let start = line.index(line.firstIndex(of: "(")!, offsetBy: 1)
                let end = line.lastIndex(of: ")")!
                root = ParseNode(parent: nil, line: String(line[start..<end]).trimmingCharacters(in: .whitespacesAndNewlines), isLeaf: false)
            }
        }catch{
        }
    }
    
    /**
     * Gets the next leaf node after the given leaf node in the ParseTree.
     - Parameters:
        - parseNode: ParseNode for which next node is calculated.
     - Returns: Next leaf node after the given leaf node.
     */
    public func nextLeafNode(parseNode: ParseNode) -> ParseNode?{
        let nodeCollector = NodeCollector(rootNode: root!, condition: IsEnglishLeaf())
        let leafList = nodeCollector.collect()
        for i in 0..<leafList.count - 1 {
            if leafList[i] === parseNode {
                return leafList[i + 1]
            }
        }
        return nil
    }

    /**
     * Gets the previous leaf node before the given leaf node in the ParseTree.
     - Parameters:
        - parseNode: ParseNode for which previous node is calculated.
     - Returns: Previous leaf node before the given leaf node.
     */
    public func previousLeafNode(parseNode: ParseNode) -> ParseNode?{
        let nodeCollector = NodeCollector(rootNode: root!, condition: IsEnglishLeaf())
        let leafList = nodeCollector.collect()
        for i in 1..<leafList.count {
            if leafList[i] === parseNode {
                return leafList[i - 1]
            }
        }
        return nil
    }

    /**
     * Calls recursive method to calculate the number of all nodes, which have more than one children.
     - Returns: Number of all nodes, which have more than one children.
     */
    public func nodeCountWithMultipleChildren() -> Int{
        return (root?.nodeCountWithMultipleChildren())!
    }
    
    /**
     * Calls recursive method to calculate the number of all nodes tree.
     - Returns: Number of all nodes in the tree.
     */
    public func nodeCount() -> Int{
        return (root?.nodeCount())!
    }
    
    /**
     * Calls recursive method to calculate the number of all leaf nodes in the tree.
     - Returns: Number of all leaf nodes in the tree.
     */
    public func leafCount() -> Int{
        return (root?.leafCount())!
    }

    public func isFullSentence() -> Bool{
        if root != nil && ParseTree.sentenceLabels.contains(root!.data!.getName()) {
            return true
        }
        return false
    }
    
    /**
     * Generates a list of constituents in the parse tree and their spans.
     - Returns: A list of constituents in the parse tree and their spans.
     */
    public func constituentSpanList() -> [ConstituentSpan]{
        var result : [ConstituentSpan] = []
        if root != nil {
            root?.constituentSpanList(startIndex: 1, list: &result)
        }
        return result
    }
    
    /**
     * Calls recursive method to restore the parents of all nodes in the tree.
     */
    public func correctParents(){
        root?.correctParents()
    }
    
    /**
     * Calls recursive method to remove all punctuation nodes from the tree.
     */
    public func stripPunctuation(){
        root?.stripPunctuation()
    }
    
    /**
     * Accessor method for the root node.
     - Returns: Root node
     */
    public func getRoot() -> ParseNode?{
        return root
    }
    
    public func description() -> String{
        return (root?.description())!
    }
    
    /**
     * Calls recursive function to convert the tree to a sentence.
     - Returns: A sentence which contains all words in the tree.
     */
    public func toSentence() -> String{
        return (root?.toSentence().trimmingCharacters(in: .whitespacesAndNewlines))!
    }
}
