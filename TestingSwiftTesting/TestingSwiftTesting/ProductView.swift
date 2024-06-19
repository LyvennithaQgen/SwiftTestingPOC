//
//  ProductView.swift
//  TestingSwiftTesting
//
//  Created by htcuser on 18/06/24.
//

import SwiftUICore
import SwiftUI

struct ProductItemView: View {
    let product: ProductListModelElement

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: product.image ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 90, height: 110)
            .cornerRadius(8)
            
            Text(product.title ?? "")
                .font(.headline)
                .lineLimit(3)
                .foregroundColor(Color("BG3"))
            
            Text("$\(product.price ?? 0.0, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(Color("BG2"))
            
            HStack {
                ForEach(0..<5) { index in
                    Image(systemName: index < Int(product.rating?.count ?? 0) ? "star.fill" : "star")
                        .foregroundColor(index < Int(product.rating?.rate ?? 0) ? Color("BG1") : .gray)
                }
                Text("(\(product.rating?.count ?? 0))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(height: 30)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
