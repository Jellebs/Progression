//
//  Extensions.swift
//  Progression
//
//  Created by Jesper Bertelsen on 09/09/2021.
//

import Foundation
import SwiftUI
import UIKit
import CoreData

//data
extension NSManagedObject {
  func toJSON() -> String? {
    let keys = Array(self.entity.attributesByName.keys)
    let dict = self.dictionaryWithValues(forKeys: keys)
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let reqJSONStr = String(data: jsonData, encoding: .utf8)
        return reqJSONStr
    }
    catch{}
    return nil
  }
}

extension EnvironmentObject {
    var hasValue: Bool {
        !String(describing: self).contains("_store: nil")
    }
}

extension UIColor: ObservableObject {
    
}
extension View {
    func primaryColorSetting() -> some View {
        modifier(PrimararyColorSetting())
    }
    func secondaryColorSetting() -> some View {
        modifier(SecondaryColorSetting())
    }
    func tertiaryColorSetting() -> some View {
        modifier(TertiaryColorSetting())
    }
    func primaryOppositeColorSetting() -> some View {
        modifier(PrimaryOppositeColorSetting())
    }
    func secondaryOppositeColorSetting() -> some View {
        modifier(SecondaryOppositeColorSetting())
    }
    func topDownColorSettings() -> some View {
        modifier(TopDownColorSettings())
    }
    func shadowSettings() -> some View {
        modifier(ShadowSettings())
    }
    
    
    @ViewBuilder
    func saturationFade(_ amount: Double, startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        ZStack {
            self
            self
                .saturation(amount)
                .mask(
                    LinearGradient(gradient: Gradient(colors: [.clear, .white]),
                        startPoint: startPoint, endPoint: endPoint
                    )
                )
        }
    }
}


