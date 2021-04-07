//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 7.04.2021.
//

import Foundation

public class IsEnglishLeaf : IsLeaf{
    
    /**
     * Implemented node condition for English leaf node.
     - Parameters:
        - parseNode: Checked node.
     - Returns: If the node is a leaf node and is not a dummy node, returns true; false otherwise.
     */
    public override func satisfies(parseNode: ParseNode) -> Bool {
        if super.satisfies(parseNode: parseNode) {
            let data = parseNode.getData()!.getName()
            let parentData = parseNode.getParent()!.getData()!.getName()
            if data.contains("*") || (data == "0" && parentData == "-NONE-") {
                return false
            }
            return true
        }
        return false
    }

}
