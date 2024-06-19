//
//  NetworkLayer.swift
//  TestingSwiftTesting
//
//  Created by htcuser on 14/06/24.
//

import Foundation

enum BaseURL: String{
    case baseURL = "https://fakestoreapi.com"
    case getProduct = "/products"
    case getCategories = "/products/categories"
    case getCart = "/carts/5"
}

enum RequestType: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkAdapter {
    func makeRequest() async throws -> URLRequest
    func performRequest() async throws -> Data
    func getResponse<T: Codable>() async throws -> T
    var baseURL :  BaseURL  {get set}
    var endPoint:  BaseURL  {get set}
}

class NetworkLayer: NetworkAdapter{
    
    var baseURL, endPoint:  BaseURL
    var requestType: RequestType
    
    init(baseURL: BaseURL = BaseURL.baseURL, endPoint: BaseURL, requestType: RequestType) {
        self.baseURL = baseURL
        self.endPoint = endPoint
        self.requestType = requestType
    }
    
    func makeRequest() async throws -> URLRequest {
        let urlString = baseURL.rawValue + endPoint.rawValue
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 1, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.requestType.rawValue
        return request
    }
    
    func performRequest() async throws -> Data {
        let request = try await makeRequest()
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "Invalid response", code: 1, userInfo: nil)
        }
        
        return data
    }
    
    func getResponse<T: Codable>() async throws -> T{
        let getData = try await performRequest()
        do{
            let result = try JSONDecoder().decode(T.self, from: getData)
            return result
        }catch{
            print(error.localizedDescription)
            throw error
        }
    }
    
    
    
}
