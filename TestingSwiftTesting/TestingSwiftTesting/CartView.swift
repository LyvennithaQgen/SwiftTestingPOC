//
//  CartView.swift
//  TestingSwiftTesting
//
//  Created by htcuser on 18/06/24.
//

import SwiftUI

struct CartView: View {
    var viewModel: TestingViewModel
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.productListData?.filter { product in
                    viewModel.cartData?.products?.contains { $0.productID == product.id } ?? false
                } ?? []) { product in
                    CartItemView(product: product, quantity: 5)
                }
            }
            .listStyle(PlainListStyle())
            
            HStack {
                Text("Subtotal (\(viewModel.cartData?.products?.count ?? 0) Item)")
                Spacer()
                Text("$ 345.45")
            }
            .padding()
            
            Button(action: {
                // Checkout action
            }) {
                Text("Checkout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("BG1"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .task {
            do{
                try await viewModel.cartData()
            }catch{
                print(error.localizedDescription)
            }
        }
        
    }
}

//#Preview {
//    CartView()
//}

struct CartItemView: View {
     var product: ProductListModelElement
     var quantity: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(product.title ?? "")
                    .font(.headline)
                Spacer()
                Button(action: {
                    // View Shop action
                }) {
                    Text("View Shop")
                }
            }
            
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: product.image ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 90, height: 110)
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(product.description ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        Text("IDR \(product.price ?? 0.0, specifier: "%.2f")")
                        
                    }
                    .font(.subheadline)
                    
                    HStack {
                        Button(action: {
                            // Remove action
                        }) {
                            Label("Remove", systemImage: "trash")
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            Text("\(quantity)")
                            Button(action: {
                                
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .padding(.leading, 5)
            }
            Divider()
        }
        .padding()
    }
}


