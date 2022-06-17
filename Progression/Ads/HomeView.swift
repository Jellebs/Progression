//
//  HomeView.swift
//  Drag Gesture Fun
//
//  Created by Jesper Bertelsen on 16/06/2022.
//

import SwiftUI

struct HomeView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack(spacing: 0) {
            content
                .padding(.top)
                .padding(.bottom)
            Spacer()
            AdView()
                .frame(height: 90)

        }.edgesIgnoringSafeArea(.all)
        .background(Color.red.opacity(0.3))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView {
            
        }
    }
}
