//
//  UIKitSlider.swift
//  ios-professional
//
//  Created by Артем on 05.06.2024.
//

import SwiftUI

struct UIKitSlider: UIViewRepresentable {

    @Binding var value: Double

    let color: UIColor

    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.thumbTintColor = color

        slider.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.valueChanged),
            for: .valueChanged
        )

        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }

}

extension UIKitSlider {

    class Coordinator: NSObject {

        @Binding var value: Double

        init(value: Binding<Double>) {
            self._value = value
        }

        @objc
        func valueChanged(_ sender: UISlider) {
            value = Double(sender.value)
        }
    }

}


struct CustomSlider: View {
    @Binding var sliderValue: Double
    @State private var sliderValueText = ""

    var body: some View {
        HStack {
            UIKitSlider(value: $sliderValue, color: .red)
                .onChange(of: sliderValue, initial: true) {
                    sliderValueText = "\(lround(sliderValue))"
                }
            Text(sliderValueText)
                .padding()
        }
    }

}




//#Preview {
//    CustomSlider()
//}
