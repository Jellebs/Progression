//
//  WeightLogo.swift
//  Progression
//
//  Created by Jesper Bertelsen on 14/09/2021.
//

import SwiftUI

struct WeightLogo: View {
    var scale: CGFloat
    var path: Path{
        let smallestRect: CGSize = CGSize(width: 0.1 * scale, height: 0.3 * scale)
        let mediumRect: CGSize = CGSize(width: 0.1 * scale, height: 0.4 * scale)
        let biggestRect: CGSize = CGSize(width: 0.1 * scale, height: 0.5 * scale)
        let cornerSize: CGSize = CGSize(width: 0.015 * scale, height: 0.05 * scale)
        var path = Path()
        
        //left side
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: 0.1 * scale, y: 0.35 * scale),
                                       size: smallestRect), cornerSize: cornerSize)
        
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: 0.2 * scale, y: 0.3 * scale),
                                       size: mediumRect), cornerSize: cornerSize)
        
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: 0.3 * scale, y: 0.25 * scale),
                                       size: biggestRect), cornerSize: cornerSize)
        
        //right side
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: 0.7 * scale, y: 0.25 * scale),
                                       size: biggestRect), cornerSize: cornerSize)
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: 0.8 * scale, y: 0.3 * scale),
                                       size: mediumRect), cornerSize: cornerSize)
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: 0.9 * scale, y: 0.35 * scale),
                                       size: smallestRect), cornerSize: cornerSize)
        
        
        return path
    }
    var line: Path {
        var path: Path = Path()
        path.move(to: CGPoint(x: 0.4 * scale, y: 0.5 * scale))
        path.addLine(to: CGPoint(x: 0.7 * scale, y: 0.5 * scale))
        return path
    }
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            line
                .stroke(lineWidth: colorScheme == .dark ? scale/30 : scale/20)
            path
                .stroke(lineWidth: colorScheme == .dark ? scale/30 : scale/20)
        }.frame(width: scale, height: scale)
    }
}

struct WeightLogo_Previews: PreviewProvider {
    static var previews: some View {
        WeightLogo(scale: 50)
    }
}
