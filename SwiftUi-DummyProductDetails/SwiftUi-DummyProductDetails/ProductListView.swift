//
//  ProductListView.swift
//  SwiftUi-DummyProductDetails
//
//  Created by TeamLeaseRegtech on 26/09/24.
//

import SwiftUI
struct DummyProduct: Codable, Identifiable {
    let id: Int
    let thumbnail: String
    let title: String
    let description: String
    let category: String
    let price: Double
}

struct ProductResponse: Codable {
    let products: [DummyProduct]
}
struct ProductListView: View {
    @State private var products:[DummyProduct] = []
    var body: some View {
        NavigationView{
            List(products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    HStack{
                        AsyncImage(url: URL(string: product.thumbnail)){
                            image in image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 70, height: 70)
                        }
                        VStack(alignment: .leading){
                            Text(product.title)
                                .font(.headline)
                                .bold()
                            Text("Price: $\(product.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .padding(.top,1)

                        }
                    }
                }
            }
            .onAppear{
                getProducts()
            }
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
                let getData = try JSONDecoder().decode(ProductResponse.self, from: data)
                self.products = getData.products
            }catch{
                print("error",error)
            }
        }.resume()
    }
}

#Preview {
    ProductListView()
}
