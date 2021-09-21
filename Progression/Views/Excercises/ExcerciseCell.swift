//
//  ExcerciseCell.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//

import SwiftUI

struct ExcerciseCell: View {
    @State var isActive: Bool = false
    @EnvironmentObject var viewModel: ViewModel
    var excercise: Excercise
    let foregroundColor: Color = {
        var (h,s,b,a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
        let color = UIColor.black
        color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        
        s += 0.1
        b += 0.1
        let newColor: Color = Color(hue: Double(h), saturation: Double(s), brightness: Double(b))
        return newColor
    }()
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                viewModel.currentExcercise = excercise
                isActive.toggle()
            } label: {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.accentColor)
                .opacity(0.6)
                .overlay(
                    HStack { Text(excercise.name).font(.title); Spacer() }.padding()
                )
                .saturationFade(0.5, startPoint: .leading, endPoint: .trailing)
            }
            if isActive {
                Graph().frame(height: 300)
            }
        }.onChange(of: viewModel.currentExcercise) { _ in
            if viewModel.currentExcercise?.id != excercise.id {
                isActive = false
            }
        }
        .foregroundColor(foregroundColor)
        .frame(height: isActive ? 380 : 80)
        .multilineTextAlignment(.leading)
    }
}

struct ExcerciseCell_Previews: PreviewProvider {
    
    static var previews: some View {
        ExcerciseCell(excercise: Excercise())
    }
}
