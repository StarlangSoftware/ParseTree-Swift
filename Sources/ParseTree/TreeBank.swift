//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 7.04.2021.
//

import Foundation

open class TreeBank {
    
    public var parseTrees : [ParseTree] = []
    
    public init(){
        
    }
    
    /**
     * A constructor of {@link TreeBank} class which reads all {@link ParseTree} files inside the given folder. For each
     * file inside that folder, the constructor creates a ParseTree and puts in inside the list parseTrees.
     - Parameters:
        - folder: Folder where all parseTrees reside.
     */
    public init(folder: String){
        let fileManager = FileManager.default
        do {
            let listOfFiles = try fileManager.contentsOfDirectory(atPath: folder)
            for file in listOfFiles {
                let thisSourceFile = URL(fileURLWithPath: #file)
                let thisDirectory = thisSourceFile.deletingLastPathComponent()
                let url = thisDirectory.appendingPathComponent(file)
                let parseTree = ParseTree(url: url)
                if parseTree.getRoot() != nil{
                    parseTrees.append(parseTree)
                }
            }
        } catch {
        }
    }

    /**
     * A constructor of {@link TreeBank} class which reads all {@link ParseTree} files with the file name satisfying the
     * given pattern inside the given folder. For each file inside that folder, the constructor creates a ParseTree
     * and puts in inside the list parseTrees.
     - Parameters:
        - folder: Folder where all parseTrees reside.
        - pattern: File pattern such as "." ".train" ".test".
     */
    public init(folder: String, pattern: String){
        let fileManager = FileManager.default
        do {
            let listOfFiles = try fileManager.contentsOfDirectory(atPath: folder)
            for file in listOfFiles {
                if file.contains(pattern){
                    let thisSourceFile = URL(fileURLWithPath: #file)
                    let thisDirectory = thisSourceFile.deletingLastPathComponent()
                    let url = thisDirectory.appendingPathComponent(file)
                    let parseTree = ParseTree(url: url)
                    if parseTree.getRoot() != nil{
                        parseTrees.append(parseTree)
                    }
                }
            }
        } catch {
        }
    }
    
    /**
     * Strips punctuation symbols from all parseTrees in this TreeBank.
     */
    public func stripPunctuation(){
        for parseTree in parseTrees{
            parseTree.stripPunctuation()
        }
    }
    
    /**
     * Returns number of trees in the TreeBank.
     - Returns: Number of trees in the TreeBank.
     */
    public func size() -> Int{
        return parseTrees.count
    }
    
    /**
     * Accessor for a single ParseTree.
     - Parameters:
        - index: Index of the parseTree.
     - Returns: The ParseTree at the given index.
     */
    public func get(index: Int) -> ParseTree{
        return parseTrees[index]
    }

}
