//
//  TestingSwiftTestingTests.swift
//  TestingSwiftTestingTests
//
//  Created by htcuser on 14/06/24.
//

import Testing
@testable import TestingSwiftTesting
import Foundation


private extension Tag {
    @Tag static var getProduct: Self
    @Tag static var getCart: Self
    
}


struct TestingViewModelTests{
    static var mockNetworkLayer: MockNetworkLayer = MockNetworkLayer()
    
    //we have a suite along with tag to describe more
    
    @Suite(.tags(.getProduct))
    struct TestingGetProductResponseData{
        
        @Test("View Model testcase for get product") func testProductsDataSuccess() async throws {
            // Given
            let viewModel = TestingViewModel(networkAdapter: mockNetworkLayer)
            mockNetworkLayer.mockEndpoint = .getProduct
            let mockProductListData = [ProductListModelElement.TestingData.testingData()]
            mockNetworkLayer.mockData = try? JSONEncoder().encode(mockProductListData)
            
            // When
            try  await viewModel.ProductsData()
            let val = try #require(await viewModel.productListData)
            
            //then
            #expect(val != nil)
            #expect(val.count == mockProductListData.count)
            #expect(val.first?.title == mockProductListData.first?.title)
            
        }
    }
    
    @Suite(.tags(.getCart))
    struct TestingGetCartResponseData{
        
        /// we can add test cases with description
        @Test("View Model testcase for get cart") func testCartDataSuccess() async throws {
            // Given
            let viewModel = TestingViewModel(networkAdapter: mockNetworkLayer)
            mockNetworkLayer.mockEndpoint = .getProduct
            let mockProductListData = [ProductListModelElement.TestingData.testingData()]
            mockNetworkLayer.mockData = try? JSONEncoder().encode(mockProductListData)
            
            // When
            try  await viewModel.ProductsData()
            let val = try #require(await viewModel.productListData)
            
            //then
            #expect(val != nil)
            #expect(val.count == mockProductListData.count)
            #expect(val.first?.title == mockProductListData.first?.title)
            
        }
        
        
        
        ///  Here when you run the whole testcase when disabled it will not called and skips fails
        ///  Also we can add the bug tagg why it is disabled
        @Test(.disabled("Sometimes Price is Zero"),
              .bug("https://blahblah.com/error", "Price sometimes give zero")) func randomPriceDataZero() async throws{
                  
              }
        
        @Test(.enabled(if: FeatureFlag.isCartEnabled))
        func getCategories() async throws{
            
        }
        
        @Test("Test gonna fail anyway")
        func getDiscountPriceAlwaysFails() async throws{
            let mockProductListData = [ProductListModelElement.TestingData.testingData()]
            withKnownIssue {
                #expect(mockProductListData.count == 0)
            }
            #expect(mockProductListData.count == 1)
            
        }
        
        /// time limit test
        @Test(.timeLimit(.seconds(3)))
        @available(iOS 16.0, *)
        func checkTimeComplexity() async throws{
            
        }
        
        /// Parameterised Testing
        @Test(arguments: [
            ProductListModelElement(id: 1, title: "Vit C+ Brightning Serum", price: 435.0, description: "Two drops per day, See the Magic in your Skin!", category: .womenSClothing, image: "http://image.jpg", rating: Rating(rate: 4.0, count: 678)),
            ProductListModelElement(id: 2, title: "Tunic purple Top", price: 45.0, description: "Make you look elegant", category: .womenSClothing, image: "http://image.jpg", rating: nil),
            ProductListModelElement(id: 3, title: "Cargo Pants", price: 35.0, description: "Travel Friendly", category: .menSClothing, image: "http://image.jpg", rating: Rating(rate: 4.0, count: 48))
        ])
        func testArrayOfData(data: ProductListModelElement) async throws{
            
            #expect(data.id != nil)
            #expect(data.title != nil)
            #expect(data.description != nil)
        }
        
    }
    
}

