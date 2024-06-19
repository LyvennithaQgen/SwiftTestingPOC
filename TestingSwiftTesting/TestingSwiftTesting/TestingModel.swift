//
//  TestingModel.swift
//  TestingSwiftTesting
//
//  Created by htcuser on 17/06/24.
//

// MARK: - ProductListModelElement
class ProductListModelElement: Codable, Identifiable {
    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var category: Category?
    var image: String?
    var rating: Rating?

    init(id: Int?, title: String?, price: Double?, description: String?, category: Category?, image: String?, rating: Rating?) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
        self.rating = rating
    }
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
class Rating: Codable, Equatable {
    static func == (lhs: Rating, rhs: Rating) -> Bool {
        lhs.rate == rhs.rate
    }
    
    var rate: Double?
    var count: Int?

    init(rate: Double?, count: Int?) {
        self.rate = rate
        self.count = count
    }
}

typealias ProductListModel = [ProductListModelElement]

extension ProductListModelElement{
    
    struct TestingData{
        static func testingData() -> ProductListModelElement{
            return .init(id: 1, title: "Hand Bag", price: 25.00, description: "Your perfect pack for everyday use and walks in the forest", category: .womenSClothing, image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 4.0, count: 432))
            
        }
        
        static func customTesting(id: Int? = 1, title: String? = "Joggers",price: Double? = 45.00, description: String? = "Perfect for Hiking!", category: Category? = .menSClothing, image: String? = "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating? = Rating(rate: 3.0, count: 453) ) -> ProductListModelElement{
            .init(id: id, title: title, price: price, description: description, category: category, image: image, rating: rating)
            
        }
    }
    
}


// MARK: - CartModel

// MARK: - CartData
class CartData: Codable {
    var id, userID: Int?
    var date: String?
    var products: [Product]?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case date, products
        case v = "__v"
    }

    init(id: Int?, userID: Int?, date: String?, products: [Product]?, v: Int?) {
        self.id = id
        self.userID = userID
        self.date = date
        self.products = products
        self.v = v
    }
}

// MARK: - Product
class Product: Codable {
    var productID, quantity: Int?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case quantity
    }

    init(productID: Int?, quantity: Int?) {
        self.productID = productID
        self.quantity = quantity
    }
}

