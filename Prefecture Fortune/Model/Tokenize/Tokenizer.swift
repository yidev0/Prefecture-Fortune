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
    
    func extractName(from text: String) -> String? {
        // Detect the language of the input text
        let detectedLanguage = detectLanguage(from: text)
        
        // Create an NLTagger instance configured for Named Entity Recognition
        let tagger = NLTagger(tagSchemes: [.nameType])
        tagger.string = text
        
        // Set the language of the tagger based on detected language
        if let language = detectedLanguage {
            tagger.setLanguage(language, range: text.startIndex..<text.endIndex)
        }
        
        // Specify the tag we're interested in (in this case, names of people)
        let options: NLTagger.Options = [.omitWhitespace, .omitPunctuation, .joinNames]
        
        // Search for the first personal name in the text, case-insensitive
        var name: String? = nil
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .nameType, options: options) { tag, tokenRange in
            if let tag = tag, tag == .personalName {
                name = String(text[tokenRange])
                return false // Stop after finding the first name
            }
            return true // Continue scanning
        }
        
        // If no name is detected, fall back on checking manually for potential names.
        if name == nil {
            // Split the text by spaces and check for potential names (no reliance on capitalization)
            let words = text.split(separator: " ")
            let nameCandidates = words.filter { $0.count > 1 } // Avoid single-character words
            
            // Return the first valid candidate, assuming it's a name
            if let firstCandidate = nameCandidates.first {
                return String(firstCandidate)
            }
        }
        
        return name
    }
    
    func extractDate(from text: String) -> Date? {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
            let range = NSRange(text.startIndex..<text.endIndex, in: text)
            
            var detectedDate: Date? = nil
            detector.enumerateMatches(in: text, options: [], range: range) { match, _, stop in
                if let match = match, let date = match.date {
                    detectedDate = date
                    stop.pointee = true
                }
            }
            
            return detectedDate
        } catch {
            print("Error creating NSDataDetector: \(error)")
            return nil
        }
    }
}
