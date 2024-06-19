//
//  TestingViewModel.swift
//  TestingSwiftTesting
//
//  Created by htcuser on 14/06/24.
//

import SwiftUI
import Foundation

protocol TestingViewModelDelegate{
    func ProductsData() async throws
    func cartData() async throws
}

@Observable
class TestingViewModel: TestingViewModelDelegate{
    var productListData: ProductListModel?
    var cartData: CartData?
    var searchText: String
    
    var networkAdapter: NetworkAdapter
    
    init(networkAdapter: NetworkAdapter = NetworkLayer(endPoint: .getProduct, requestType: .get), searchText: String = "") {
        self.networkAdapter = networkAdapter
        self.searchText = searchText
    }
    
    func ProductsData() async throws {
        do{
            productListData = try await networkAdapter.getResponse()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func cartData() async throws{
        networkAdapter.endPoint = .getCart
        
        do{
            cartData = try await networkAdapter.getResponse()
        }catch{
            print(error.localizedDescription)
        }
    }
    
}

struct FeatureFlag{
    static var isCartEnabled: Bool = true
}
