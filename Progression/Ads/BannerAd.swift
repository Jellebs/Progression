//
//  BannerAd.swift
//  Drag Gesture Fun
//
//  Created by Jesper Bertelsen on 14/06/2022.
//

import Foundation
import SwiftUI
import GoogleMobileAds
//BannerAd
struct BannerAdView: UIViewRepresentable {
    var unitID: String
    var width: CGFloat = 10
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
        
    }
    
    func makeUIView(context: Context) -> GADBannerView {
        //Adaptive width - Får appen til at crashe indtil videre.
        
        let adSize: GADAdSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(width)
        let adView = GADBannerView(adSize: adSize)
        adView.adUnitID = unitID
        adView.rootViewController = UIApplication.shared.getRootViewController()
        adView.delegate = context.coordinator
        adView.backgroundColor = UIColor.red
        adView.load(GADRequest())
        return adView
    }
    func updateUIView(_ uiView: GADBannerView, context: Context) {
        
    }
    
    class Coordinator: NSObject, GADBannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
          print("bannerViewDidReceiveAd")
        }

        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
          print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }

        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
          print("bannerViewDidRecordImpression")
        }

        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
          print("bannerViewWillPresentScreen")
        }

        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
          print("bannerViewWillDIsmissScreen")
        }

        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
          print("bannerViewDidDismissScreen")
        }
    }
}

extension UIApplication {
    func getRootViewController() -> UIViewController {
        guard let scenes =
                self.connectedScenes.first as? UIWindowScene else { return .init() }
        guard let root = scenes.windows.first?.rootViewController else { return .init() }
        
        return root
    }
}
