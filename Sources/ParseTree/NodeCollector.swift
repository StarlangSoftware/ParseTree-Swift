//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 7.04.2021.
//

import Foundation

public class NodeCollector {
    
    private var condition: NodeCondition
    private var rootNode: ParseNode
    
    /**
     * Constructor for the NodeCollector class. NodeCollector's main aim is to collect a set of ParseNode's from a
     * subtree rooted at rootNode, where the ParseNode's satisfy a given NodeCondition, which is implemented by other
     * interface class.
     - Parameters:
        - rootNode: Root node of the subtree
        - condition: The condition interface for which all nodes in the subtree rooted at rootNode will be checked
     */
    public init(rootNode: ParseNode, condition: NodeCondition){
        self.condition = condition
        self.rootNode = rootNode
    }
    
    /**
     * Private recursive method to check all descendants of the parseNode, if they ever satisfy the given node condition
     - Parameters:
        - parseNode: Root node of the subtree
        - collected: The {@link ArrayList} where the collected ParseNode's will be stored.
     */
    private func collectNodes(parseNode: ParseNode, collected: inout [ParseNode]){
        if condition.satisfies(parseNode: parseNode) {
            collected.append(parseNode)
        } else {
            for i in 0..<parseNode.numberOfChildren() {
                collectNodes(parseNode: parseNode.getChild(i: i), collected: &collected)
            }
        }
    }
    
    /**
     * Collects and returns all ParseNode's satisfying the node condition.
     - Returns: All ParseNode's satisfying the node condition.
     */
    public func collect() -> [ParseNode]{
        var result : [ParseNode] = []
        collectNodes(parseNode: rootNode, collected: &result)
        return result
    }
}
