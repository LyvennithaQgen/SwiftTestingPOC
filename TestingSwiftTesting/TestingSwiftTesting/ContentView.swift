//
//  ContentView.swift
//  TestingSwiftTesting
//
//  Created by htcuser on 14/06/24.
//

import SwiftUI

struct ContentView: View {
    
    
    var viewModel = TestingViewModel()
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                TextField("Search product here", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray4))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .onChange(of: searchText) { oldValue, newValue in
                        viewModel.searchText = newValue
                    }
                
                // Filter options
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button("Category 1") { }
                            .foregroundStyle(Color("BG2"))
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                        
                        Button("Brand") { }
                            .foregroundStyle(Color("BG2"))
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                        
                        Button("Price") { }
                            .foregroundStyle(Color("BG2"))
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                        
                        Button("Offer") { }
                            .foregroundStyle(Color("BG2"))
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                
                // Product grid
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.productListData?.filter { viewModel.searchText.isEmpty ? true : $0.title?.contains(viewModel.searchText) ?? false } ?? []) { product in
                            ProductItemView(product: product)
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 2)
            }
            .background(Color(.systemGray6))
            .task {
                do{
                    try await viewModel.ProductsData()
                }catch{
                    print(error.localizedDescription)
                }
            }
            .toolbar {
                NavigationLink {
                    CartView(viewModel: viewModel)
                        .navigationBarTitle("Cart", displayMode: .inline)
                } label: {
                    
                    Image(systemName: "cart.fill.badge.plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("BG2"))
                }
                
            }
            .navigationTitle("Products")
        }
    }
}

#Preview {
    ContentView()
}

/*
 {
     NavigationView{
         List(viewModel.productListData ?? []) { item in
             HStack{
                 
                 AsyncImage(url: URL(string: item.image ?? "")!) { image in
                     image
                         .resizable()
                         .frame(width: 90, height: 110)
                 } placeholder: {
                     ProgressView()
                 }
                 VStack(alignment: .leading){
                     
                     Text(item.title ?? "")
                         .foregroundStyle(.primary)
                     Text(item.description ?? "")
                         .foregroundStyle(.secondary)
                         .font(.system(size: 10))
                     ZStack{
                         Rectangle()
                             .fill(Color.yellow)
                             .frame(width: 110, height: 35)
                             .cornerRadius(3)
                         Text("$ \(item.price ?? 0.0, specifier: "%.2f")")
                             .bold()
                     }
                 }
             }
             
         }
         
         .padding(.bottom, 10)
         .listStyle(.plain)
         
         .task {
             do{
                 try await viewModel.ProductsData()
             }catch{
                 print(error.localizedDescription)
             }
         }
         .navigationBarTitle("Home", displayMode: .inline)
         .toolbar {
             NavigationLink {
                 CartView()
                     .navigationTitle("CART")
             } label: {
                 ZStack{
                     Image(systemName: "cart.badge.plus")
                         .resizable()
                         .frame(width: 30, height: 30)
                         .foregroundStyle(Color.black)
                     Image(systemName: "cart.fill.badge.plus")
                         .resizable()
                         .frame(width: 27, height: 27)
                         .foregroundColor(.yellow)
                 }
             }
             
         }
//            .background(Color("BG1"))
     }
    
 }
 */
