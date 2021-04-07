//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 6.04.2021.
//

import Foundation

public class ConstituentSpan {
    
    private var constituent: Symbol
    private var start: Int
    private var end: Int
    
    public init(constituent: Symbol, start: Int, end: Int){
        self.constituent = constituent
        self.start = start
        self.end = end
    }
    
    public func getConstituent() -> Symbol{
        return constituent
    }
    
    public func getStart() -> Int{
        return start
    }
    
    public func getEnd() -> Int{
        return end
    }
}
