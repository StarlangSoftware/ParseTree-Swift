//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 7.04.2021.
//

import Foundation

public protocol NodeCondition{
    
    func satisfies(parseNode: ParseNode) -> Bool
    
}
