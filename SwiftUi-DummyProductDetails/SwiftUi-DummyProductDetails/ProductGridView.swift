//
//  ProductGridView.swift
//  SwiftUi-DummyProductDetails
//
//  Created by TeamLeaseRegtech on 26/09/24.
//

import SwiftUI
struct ProductData: Codable, Identifiable {
    let id: Int
    let thumbnail: String
    let title: String
    let description: String
    let category: String
    let price: Double
}

struct PResponse: Codable {
    let products: [ProductData]
}
struct ProductGridView: View {
    @State private var products : [ProductData] = []
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(products) { product in
                        
                        VStack(alignment: .leading, spacing: 8) {
                            AsyncImage(url: URL(string: product.thumbnail)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120, height: 120)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 140, height: 140)
                            }
                            
                            Text(product.title)
                                .font(.headline)
                                .lineLimit(2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("Price: $\(product.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .frame(width: 160)
                    }
                }
              .onAppear{
                getProducts()
            }
                .padding(.horizontal)
            }
    }
    private func getProducts() {
        guard let url = URL(string: "https://dummyjson.com/products") else{
            return
        }
        URLSession.shared.dataTask(with: url){
            data,response,error in
            guard let data = data,error == nil else{
                print("no data")
                return
            }
            do{
                let getData = try JSONDecoder().decode(PResponse.self, from: data)
                self.products = getData.products
            }catch{
                print("error",error)
            }
        }.resume()
    }
}

#Preview {
    ProductGridView()
}
