//
//  AuthenticationTests.swift
//  AuthenticationTests
//
//  Created by ahmed sultan on 02/09/2021.
//

import XCTest
@testable import Authentication

class AuthenticationTests: XCTestCase {
    
    let mockAuthParser = MockAuthParser()

    override func tearDownWithError() throws {
        mockAuthParser.reset()
    }
    
    func testparseResponse() throws {
        
        mockAuthParser.shouldReturnError = false

        guard let imageMetaData = mockAuthParser.parseResponse(mockAuthParser.jsonResponse, responseType: ProfileResponse.self) else {
            XCTFail()
            return
        }
        XCTAssertNotNil(imageMetaData)
    }
    
    func testParseProfile() throws {
        
        mockAuthParser.shouldReturnError = false
        guard let profile = self.mockAuthParser.parse(self.mockAuthParser.jsonResponse, responseType: ProfileResponse.self) else {
            XCTFail()
            return
        }
        XCTAssertNotNil(profile)
    }
}
