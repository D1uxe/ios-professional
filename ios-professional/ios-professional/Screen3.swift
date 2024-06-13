//
//  Screen3.swift
//  ios-professional
//
//  Created by Артем on 13.06.2024.
//

import SwiftUI

struct Screen3: View {

    @State private var isPresented = false
    @State private var red = Double.random(in: 0...255)

    var body: some View {

        VStack {
            Button("Show Modal") {
                isPresented.toggle()
            }
            .foregroundColor(Color(red: red / 255, green: 0.5, blue: 0.2))
            .sheet(isPresented: $isPresented) {
                Text("Modal View").padding()
                Button("Dismiss") {
                    isPresented.toggle()
                }
            }

            CustomSlider(sliderValue: $red)
        }
    }

}
