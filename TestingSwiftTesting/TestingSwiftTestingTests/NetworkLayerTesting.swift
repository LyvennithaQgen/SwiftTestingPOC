//
//  NetworkLayerTesting.swift
//  TestingSwiftTesting
//
//  Created by htcuser on 18/06/24.
//


import Testing
@testable import TestingSwiftTesting
import Foundation

struct NetworkLayerTests{
    
    let mockNetworkLayer: MockNetworkLayer = MockNetworkLayer()
    
    @Test("Make Request") func test_MakeRequestSuccess() async throws{
        mockNetworkLayer.shouldReturnError = false
        mockNetworkLayer.mockEndpoint = .getProduct
        
        mockNetworkLayer.mockURLRequest = URLRequest(url: URL(string: BaseURL.baseURL.rawValue + (mockNetworkLayer.mockEndpoint?.rawValue ?? ""))!)
        
        let uRLRequest = try await mockNetworkLayer.makeRequest()
        #expect(uRLRequest == URLRequest(url: URL(string: BaseURL.baseURL.rawValue + (mockNetworkLayer.mockEndpoint?.rawValue ?? ""))!))
        
    }
    
    @Test("perform Request") //Adding Display Name
    func test_performRequestSuccess() async throws {
        mockNetworkLayer.shouldReturnError = false
        mockNetworkLayer.mockData = contentsOfJSON(jsonName: "product")
        
        let mockData = try await mockNetworkLayer.performRequest()
        #expect(mockData == contentsOfJSON(jsonName: "product"))
    }
    
    @Test("Get Response")
    func test_resultData() async throws{
        let response = ProductListModelElement.TestingData.testingData()
        mockNetworkLayer.mockData = try? JSONEncoder().encode(response)
        
        let mockData: ProductListModelElement = try await mockNetworkLayer.getResponse()
        #expect(mockData.title == "Hand Bag")
        
    }
    
    @discardableResult func contentsOfJSON(jsonName: String) -> Data{
        if let path = Bundle.main.path(forResource: jsonName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("No file found", error.localizedDescription)
            }
            
        }
        return Data()
    }
    
}
