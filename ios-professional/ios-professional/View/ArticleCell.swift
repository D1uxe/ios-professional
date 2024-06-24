//
//  ArticleCell.swift
//  ios-professional
//
//  Created by Бугров Артем on 24.06.2024.
//

import SwiftUI

struct ArticleCell: View {

    @State private var toggleAnimation: Bool = false

    let title: String?
    let description: String?
    var onAnimate: (CGPoint, CGSize) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).foregroundStyle(.gray)

            VStack(alignment: .leading) {
                Text(title ?? "Нет заголовка")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                Text(description ?? "Нет контента")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding()

            }
            .background (
                GeometryReader { geometry in
                    Color.clear
                        .contentShape(Rectangle())
                        .onChange(of: toggleAnimation) {
                            let globalFrame = geometry.frame(in: .global)
                            onAnimate(
                                CGPoint(x: globalFrame.midX, y: globalFrame.minY - 50),
                                geometry.size
                            )
                        }

                }
            )
            .onTapGesture {
                toggleAnimation.toggle()
            }
        }
    }
}


struct ArticleFlyawayView: View {

    let title: String?
    let description: String?
    let size: CGSize

    @Binding var animate: Bool
    @Binding var flyOffset: CGPoint
    @Binding var flyAway: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).foregroundStyle(.gray)

            VStack(alignment: .leading) {
                Text(title ?? "Нет заголовка")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                Text(description ?? "Нет контента")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding()
            }
        }
        .frame(width: size.width, height: size.height)
        .position(x: flyOffset.x, y: flyOffset.y)
        .offset(
            x: flyAway ? UIScreen.main.bounds.width - flyOffset.x : 0,
            y: flyAway ? UIScreen.main.bounds.height - flyOffset.y : 0
        )
        .rotationEffect(.degrees(flyAway ? 45 : 0))
        .opacity(flyAway ? 0 : 1)
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                flyAway = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.flyAway = false
                self.animate = false
            }
        }
    }
}
