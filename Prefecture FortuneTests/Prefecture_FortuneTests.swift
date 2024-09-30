//
//  Prefecture_FortuneTests.swift
//  Prefecture FortuneTests
//
//  Created by Yuto on 2024/09/24.
//

import Testing
@testable import Prefecture_Fortune

struct Prefecture_FortuneTests {

    @Test func testDefaultAPICall() {
        Task {
            let fortuneAPIClient = FortuneAPIClient()
            let result = await fortuneAPIClient.fetchResponse(
                reqeust: .sample
            )
            
            var responseResult: FortuneResponse? = nil
            switch result {
            case .success(let response):
                responseResult = response
            case .failure:
                break
            }
            
            #expect(responseResult?.name == FortuneResponse.sample.name)
        }
    }

    @Test func testTokenizer() {
        let tokenizer = Tokenizer()
        let tokenized = tokenizer.tokenize(text: "Hello, World!")
        
        #expect(tokenized.count == 2)
        #expect(tokenized[0] == "Hello")
        #expect(tokenized[1] == "World")
    }
    
    @Test func testTokenizerWithShortInputEN() {
        let input = "Micheal Scott, type a, 3/15/1965."
        let tokenizer = Tokenizer()
        
        let name = tokenizer.extractName(from: input)
        let date = tokenizer.extractDate(from: input)
        
        print(tokenizer.tokenize(text: input))
        print(name ?? "error")
        print(date as Any)
        
        #expect((name ?? "error") == "Micheal Scott")
        #expect(date?.get(component: .year) == 1965 && date?.get(component: .month) == 3 && date?.get(component: .day) == 15)
    }
    
    @Test func testTokenizerWithShortInputJP() {
        let input = "ゆめみん a型 2000年1月27日"
        let tokenizer = Tokenizer()
        
        let name = tokenizer.extractName(from: input)
        let date = tokenizer.extractDate(from: input)
        
        print(tokenizer.tokenize(text: input))
        print(name ?? "error")
        print(date as Any)
        
        #expect((name ?? "error") == "ゆめみん")
        #expect(date?.get(component: .year) == 2000 && date?.get(component: .month) == 1 && date?.get(component: .day) == 27)
    }
    
    @Test func testTokenizerWithLongInputEN() {
        let input = "I am micheal scott, from scranton pennsylvania. My blood type is a, and I was born on 3/15/1965."
        let tokenizer = Tokenizer()
        
        let name = tokenizer.extractName(from: input)
        let date = tokenizer.extractDate(from: input)
        
        print(tokenizer.tokenize(text: input))
        print(name ?? "error")
        print(date as Any)
        
        #expect((name ?? "error") == "micheal")
        #expect(date?.get(component: .year) == 1965 && date?.get(component: .month) == 3 && date?.get(component: .day) == 15)
    }
    
    @Test func testTokenizerWithLongInputJP() {
        let input = "私の名前はゆめみんです。a型で誕生日は9/23です。"
        let tokenizer = Tokenizer()
        
        let name = tokenizer.extractName(from: input)
        let date = tokenizer.extractDate(from: input)
        
        print(tokenizer.tokenize(text: input))
        print(name ?? "error")
        print(date as Any)
        
        #expect((name ?? "error") == "ゆめみん")
        #expect(date?.get(component: .year) == 2000 && date?.get(component: .month) == 1 && date?.get(component: .day) == 27)
    }
}
