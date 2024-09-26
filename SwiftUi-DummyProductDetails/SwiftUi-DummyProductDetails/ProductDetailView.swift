//
//  ProductDetailView.swift
//  SwiftUi-DummyProductDetails
//
//  Created by TeamLeaseRegtech on 26/09/24.
//

import SwiftUI

struct ProductDetailView: View {
    let product : DummyProduct
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 250)
                } placeholder: {
                    ProgressView()
                        .frame(width: 300, height: 300)
                }

                Text(product.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top)

                Text("Price: $\(product.price, specifier: "%.2f")")
                    .font(.title2)
                    .padding(.top)

                Text("Category: \(product.category)")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .padding(.top, 2)

                Text(product.description)
                    .padding(.top, 8)
            }
            .padding()
        }.navigationTitle("")
    }
}
