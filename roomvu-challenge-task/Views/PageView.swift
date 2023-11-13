//
//  PageView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import SwiftUI

struct PageView<Content: View>: View {
    @State private var selection = 0
    var views: [Content]

    var body: some View {
        VStack {
            PageControl(numberOfPages: views.count, currentPage: $selection)
            TabView(selection: $selection) {
                ForEach(views.indices, id: \.self) { index in
                    views[index]
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPageIndicatorTintColor = UIColor.systemBlue
        control.pageIndicatorTintColor = UIColor.gray
        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}
