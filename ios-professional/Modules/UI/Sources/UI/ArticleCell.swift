//
//  ArticleCell.swift
//  ios-professional
//
//  Created by Артем on 24.06.2024.
//

import SwiftUI

public struct ArticleCell: View {

    @State private var toggleAnimation: Bool = false

    let title: String?
    let description: String?
    var onAnimate: (CGPoint, CGSize) -> Void

    public init(title: String?, description: String?, onAnimate: @escaping (CGPoint, CGSize) -> Void) {
        self.title = title
        self.description = description
        self.onAnimate = onAnimate
    }

    public var body: some View {
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


public struct ArticleFlyawayView: View {

    let title: String?
    let description: String?
    let size: CGSize

    @Binding var animate: Bool
    @Binding var flyOffset: CGPoint
    @Binding var flyAway: Bool

    public init(title: String?, description: String?, size: CGSize, animate: Binding<Bool>, flyOffset: Binding<CGPoint>, flyAway: Binding<Bool>) {
        self.title = title
        self.description = description
        self.size = size
        self._animate = animate
        self._flyOffset = flyOffset
        self._flyAway = flyAway
    }
    
    public var body: some View {
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
