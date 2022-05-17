//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 17.05.2022.
//

import Foundation

open class ParallelTreeBank{
    
    public var fromTreeBank, toTreeBank : TreeBank
    
    init(folder1: String, folder2: String){
        fromTreeBank = TreeBank(folder: folder1)
        toTreeBank = TreeBank(folder: folder2)
        removeDifferentTrees()
    }

    init(folder1: String, folder2: String, pattern: String){
        fromTreeBank = TreeBank(folder: folder1, pattern: pattern)
        toTreeBank = TreeBank(folder: folder2, pattern: pattern)
        removeDifferentTrees()
    }
    
    public func removeDifferentTrees(){
        var i : Int = 0
        var j : Int = 0
        while (i < fromTreeBank.size() && j < toTreeBank.size()){
            if fromTreeBank.get(index: i).getName() < toTreeBank.get(index: j).getName(){
                fromTreeBank.removeTree(index: i);
            } else {
                if toTreeBank.get(index: j).getName() > fromTreeBank.get(index: i).getName(){
                    toTreeBank.removeTree(index: j);
                } else {
                    i = i + 1
                    j = j + 1
                }
            }
        }
        while (i < fromTreeBank.size()){
            fromTreeBank.removeTree(index: i);
        }
        while (j < toTreeBank.size()){
            toTreeBank.removeTree(index: j);
        }
    }

    public func size() -> Int{
        return fromTreeBank.size()
    }
    
    public func fromTree(index: Int) -> ParseTree{
        return fromTreeBank.get(index: index)
    }
    
    public func toTree(index: Int) -> ParseTree{
        return toTreeBank.get(index: index)
    }
    
    public func getFromTreeBank() -> TreeBank{
        return fromTreeBank
    }
    
    public func getToTreeBank() -> TreeBank{
        return toTreeBank
    }
}
