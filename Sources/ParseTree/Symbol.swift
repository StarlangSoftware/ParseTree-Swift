//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 6.04.2021.
//

import Foundation
import Dictionary

public class Symbol : Word{
    private static var nonTerminalList : [String] = ["ADJP", "ADVP", "CC", "CD", "CONJP", "DT", "EX", "FRAG", "FW", "IN", "INTJ", "JJ", "JJR", "JJS", "LS",
            "LST", "MD", "NAC", "NN", "NNP", "NNPS", "NNS", "NP", "NX", "PDT", "POS", "PP", "PRN", "PRP", "PRP$", "PRT",
            "PRT|ADVP", "QP", "RB", "RBR", "RP", "RRC", "S", "SBAR", "SBARQ", "SINV", "SQ", "SYM", "TO", "UCP", "UH", "VB", "VBD", "VBG", "VBN",
            "VBP", "VBZ", "VP", "WDT", "WHADJP", "WHADVP", "WHNP", "WP", "WP$", "WRB", "X", "-NONE-"]
    private static var phraseLabels : [String] = ["NP", "PP", "ADVP", "ADJP", "CC", "VG"]
    private static var sentenceLabels : [String] = ["SINV","SBARQ","SBAR","SQ","S"]
    private static var verbLabels : [String] = ["VB", "VBD", "VBG", "VBN","VBP", "VBZ", "VERB"]
    private static var VPLabel : String = "VP"

    /**
     * Constructor for Symbol class. Sets the name attribute.
     - Parameters:
        - name: Name attribute
     */
    public override init(name: String){
        super.init(name: name)
    }
    
    /**
     * Checks if this symbol is a verb type.
     - Returns: True if the symbol is a verb, false otherwise.
     */
    public func isVerb() -> Bool{
        return Symbol.verbLabels.contains(getName())
    }
    
    /**
     * Checks if the symbol is VP or not.
     - Returns: True if the symbol is VB, false otherwise.
     */
    public func isVP() -> Bool{
        return getName() == Symbol.VPLabel
    }
    
    /**
     * Checks if this symbol is a terminal symbol or not. A symbol is terminal if it is a punctuation symbol, or
     * if it starts with a lowercase symbol.
     - Returns: True if this symbol is a terminal symbol, false otherwise.
     */
    public func isTerminal() -> Bool{
        let name = getName()
        if name == "," || name == "." || name == "!" || name == "?" || name == ":"
                || name == ";" || name == "\"" || name == "''" || name == "'" || name == "`"
            || name == "``" || name == "..." || name == "-" || name == "--"{
            return true
        }
        if Symbol.nonTerminalList.contains(name){
            return false
        }
        if name == "I" || name == "A"{
            return true
        }
        for i in 0..<name.count {
            if Word.charAt(s: name, i: i) >= "a" && Word.charAt(s: name, i: i) <= "z" {
                return true
            }
        }
        return false
    }
    
    /**
     * Checks if this symbol can be a chunk label or not.
     - Returns: True if this symbol can be a chunk label, false otherwise.
     */
    public func isChunkLabel() -> Bool{
        let name = getName()
        if Word.isPunctuationSymbol(surfaceForm: name) || Symbol.sentenceLabels.contains(name.replacingOccurrences(of: "-*", with: "")) || Symbol.phraseLabels.contains(name.replacingOccurrences(of: "-.*", with: "")){
            return true
        }
        return false
    }
    
    /**
     * If the symbol's data contains '-' or '=', this method trims all characters after those characters and returns
     * the resulting string.
     - Returns: Trimmed symbol.
     */
    public func trimSymbol() -> Symbol{
        let name = getName()
        if (name.hasPrefix("-") || (!name.contains("-") && !name.contains("="))){
            return self
        }
        let minus = name.firstIndex(of: "-")
        let equal = name.firstIndex(of: "=")
        if minus != nil || equal != nil{
            if minus != nil && equal != nil {
                let minusIndex = name.distance(from: name.startIndex, to: minus!)
                let equalIndex = name.distance(from: name.startIndex, to: minus!)
                if minusIndex < equalIndex {
                    return Symbol(name: String(name.prefix(minusIndex)))
                } else {
                    return Symbol(name: String(name.prefix(equalIndex)))
                }
            } else {
                if minus != nil {
                    let minusIndex = name.distance(from: name.startIndex, to: minus!)
                    return Symbol(name: String(name.prefix(minusIndex)))
                } else {
                    let equalIndex = name.distance(from: name.startIndex, to: minus!)
                    return Symbol(name: String(name.prefix(equalIndex)))
                }
            }
        } else {
            return self
        }
    }
}
