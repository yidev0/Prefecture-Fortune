//
//  Tokenizer.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/25.
//
//  https://qiita.com/ya_s_u/items/2a6364040f9b184a9679
//  https://qiita.com/mashunzhe/items/28c06eafc024954e4256

import Foundation
import NaturalLanguage

struct Tokenizer {

    func detectLanguage(text: String) -> NLLanguage? {
    func detectLanguage(from text: String) -> NLLanguage? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        return recognizer.dominantLanguage
    }

    func tokenize(text: String, by unit: NLTokenUnit = .word) -> [String] {
        let tokenizer = NLTokenizer(unit: unit)
        tokenizer.string = text
        let tokens = tokenizer.tokens(for: text.startIndex ..< text.endIndex)
        let textTokens: [String] = tokens.map { token in
            let tokenStartI = token.lowerBound
            let tokenEndI = token.upperBound
            let text = text[tokenStartI ..< tokenEndI]
            return String(text)
        }
        
        return textTokens
    }
    
}
