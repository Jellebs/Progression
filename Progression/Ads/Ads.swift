//
//  Ads.swift
//  Drag Gesture Fun
//
//  Created by Jesper Bertelsen on 22/05/2022.
//

import SwiftUI
import GoogleMobileAds
//BannerAd
struct AdView: View {
    
    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .top) {
                BannerAdView(unitID:
                                "ca-app-pub-3940256099942544/2934735716"
                             /* rigtige ad id: "ca-app-pub-9187872266171766/6181947500"*/,
                             width: geo.size.width)
                    .frame(height: 50)
                
            }.padding(.bottom, 40)
                .background(Color.black)
                
            
        }
        
    }
}


struct Ads_Previews: PreviewProvider {
    static var previews: some View {
        BannerAdView(unitID: "ca-app-pub-3940256099942544/2934735716", width: 320)
    }
}
