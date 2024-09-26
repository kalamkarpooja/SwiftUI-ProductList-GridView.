//
//  ContentView.swift
//  SwiftUi-DummyProductDetails
//
//  Created by TeamLeaseRegtech on 26/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedSegment = 0
    var body: some View {
        VStack {
            Picker("Choose View", selection: $selectedSegment) {
                Text("ProductList").tag(0)
                Text("ProductGrid").tag(1) 
            }
            .pickerStyle(SegmentedPickerStyle())
           Spacer()
            
            if selectedSegment == 0{
                ProductListView()
            }else{
                ProductGridView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
