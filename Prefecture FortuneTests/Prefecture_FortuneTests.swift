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

}
