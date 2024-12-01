//
//  NetworkTest.swift
//  NetworkTest
//
//  Created by minsong kim on 11/19/24.
//

import XCTest
@testable import echog

final class NetworkTest: XCTestCase {
    var sut: NetworkManager!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: configuration)
        let baseURLManager = BaseURLManager()
        baseURLManager.register(URL(string: "http://echog.com")!, for: .api)
        
        sut = NetworkManager(baseURLResolver: baseURLManager, plugins: [], session: mockSession)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_SuccessfulResponse() throws {
        let jsonString = """
                        {
                            "status": "200",
                            "message": "Login successful",
                            "data": {
                                "email": "test@example.com",
                                "nickname": "testuser",
                                "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
                                "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
                            }
                        }
                        """
        let data = jsonString.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw NetworkError.urlNotFound
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            
            return (response, data)
        }
        
        Task {
            let fetchData = try await sut.fetchData(UserLoginNetworkBuilder(loginId: "test@example.com", password: "securepassword"))
            XCTAssertEqual(fetchData.email, "test@example.com")
            XCTAssertEqual(fetchData.nickname, "testuser")
            XCTAssertEqual(fetchData.token, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...")
            XCTAssertEqual(fetchData.refreshToken, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...")
        }
    }
}
