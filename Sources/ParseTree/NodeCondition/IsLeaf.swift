//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 7.04.2021.
//

import Foundation

public class IsLeaf : NodeCondition{
    
    /**
     * Implemented node condition for the leaf node. If a node has no children it is a leaf node.
     - Parameters:
        - parseNode: Checked node.
     - Returns: True if the input node is a leaf node, false otherwise.
     */
    public func satisfies(parseNode: ParseNode) -> Bool {
        return parseNode.numberOfChildren() == 0
    }
    
}
