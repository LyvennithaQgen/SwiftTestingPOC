//
//  MockNetworkLayer.swift
//  TestingSwiftTesting
//
//  Created by htcuser on 17/06/24.
//

import Foundation

class MockNetworkLayer: NetworkAdapter{
    var baseURL: BaseURL
    var endPoint: BaseURL
    
    
    var shouldReturnError = false
    var mockData: Data?
    var mockURLRequest: URLRequest?
    var mockEndpoint: BaseURL?
    
    init(baseURL: BaseURL = .baseURL, endPoint: BaseURL = .getProduct, shouldReturnError: Bool = false, mockData: Data? = nil, mockURLRequest: URLRequest? = nil, mockEndpoint: BaseURL? = nil) {
        self.baseURL = baseURL
        self.endPoint = endPoint
        self.shouldReturnError = shouldReturnError
        self.mockData = mockData
        self.mockURLRequest = mockURLRequest
        self.mockEndpoint = mockEndpoint
    }
    
    func makeRequest() async throws -> URLRequest {
        if shouldReturnError {
            throw NSError(domain: "Mock error", code: 1, userInfo: nil)
        }
        
        guard let mockRequest = mockURLRequest else {
            throw NSError(domain: "Mock URLRequest not set", code: 1, userInfo: nil)
        }
        
        return mockRequest
    }
    
    func performRequest() async throws -> Data {
        if shouldReturnError {
            throw NSError(domain: "Mock error", code: 1, userInfo: nil)
        }
        
        guard let data = mockData else {
            throw NSError(domain: "No mock data", code: 1, userInfo: nil)
        }
        
        return data
    }
    
    func getResponse<T>() async throws -> T where T : Decodable, T : Encodable {
        let getData = try await performRequest()
        do {
            let result = try JSONDecoder().decode(T.self, from: getData)
            return result
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
}
