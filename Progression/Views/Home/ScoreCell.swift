//
//  ExcerciseCell.swift
//  Progression
//
//  Created by Jesper Bertelsen on 26/08/2021.
//

import SwiftUI
//MARK: - Mainview
struct ScoreCell: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var score: JBScore
    let colorTheme: Color
    init(colorTheme: Color = .black) {
        self.colorTheme = colorTheme
    }
    var body: some View {
        CellView({ viewModel.deleteScore(score: score)}) {
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(score.excercise.name)")
                        Spacer()
                        Pickers(colorTheme: .black)
                            .font(.title3)
                    }
                    Spacer()
                    Text("Total volume \n \(score.stats.volume)")
                }
                Spacer()
            }.padding()
            .frame(maxHeight:.infinity)
            .onChange(of: score.stats) { stat in
                viewModel.saveScore(score: score)
            }
            
        }.font(.title2)
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
    }
}
// MARK: Pickers
fileprivate struct Pickers: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var score: JBScore 
    @State var colorTheme: Color
    var body: some View {
        HStack {
            VStack {
                Text("Sets").fontWeight(.light)
                Picker("Sets", selection: $score.stats.sets) {
                    ForEach(0..<10) { i in
                        PickerCell(number: "\(i)")
                        .tag(Int(i))
                    }
                }
                .frame(width: 50, height: 60)
                .clipped()
            }
            VStack {
                Text("Reps").fontWeight(.light)
                Picker("Reps", selection: $score.stats.reps) {
                    ForEach(0..<25) { i in
                        PickerCell(number: "\(i)")
                        .tag(Int(i))
                    }
                }
                .frame(width: 50, height: 60)
                .clipped()
            }
            VStack {
                Text("Weights").fontWeight(.light)
                Picker("Weights", selection: $score.stats.weight) {
                    ForEach(0..<250) { i in
                        PickerCell(number: "\(i)")
                        .tag(Double(i))
                    }
                }
                .frame(width: 50, height: 60)
                .clipped()
            }
            Spacer()
        }.environmentObject(UIColor(colorTheme))
        .frame(height: 74)
    }
}
struct PickerCell: View {
    @EnvironmentObject var colorTheme: UIColor
    init(number: String = "") {
        self.number = number
        
    }
    init(excercise: Excercise) {
        self.excercise = excercise
    }
    var excercise: Excercise? = nil
    var number: String? = nil
    var body: some View {
        if excercise != nil {
            Text(excercise!.name)
                .tag(excercise.self)
                .font(.title2)
                .foregroundColor(_colorTheme.hasValue ? Color(colorTheme) : .primary)
        } else {
        Text(number!)
            .fontWeight(.light)
            .foregroundColor(_colorTheme.hasValue ? Color(colorTheme) : .primary)
        }
    }
}

struct ScoreCell_Previews: PreviewProvider {
    static var previews: some View {
        ScoreCell(colorTheme: .white)
    }
}
