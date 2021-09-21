//
//  ExcerciseCell.swift
//  Progression
//
//  Created by Jesper Bertelsen on 26/08/2021.
//

import SwiftUI

struct ScoreCell: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var score: JBScore
    @State var isMainView: Bool = true
    
    var body: some View {
        Button {
            isMainView.toggle()
        } label: {
            if isMainView {
                ScoreCell_MainView(score: $score, colorTheme: .black)
            } else {
                DetailView(score: score)
            }
            
        }.frame(maxWidth: .infinity)
        .frame(height: 140)
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).foregroundColor(.accentColor)
                        .opacity(0.4))
    }
}
//MARK: Main View
struct ScoreCell_MainView: View {
    @Binding var score: JBScore
    let colorTheme: Color
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(score.excercise.name)")
                    .font(.title2)
                HStack {
                    VStack {
                        Text("Sets")
                        Picker("Sets", selection: $score.stats.sets) {
                            ForEach(0..<10) { i in
                                Text("\(i)").foregroundColor(colorTheme).tag(Int(i))
                            }
                        }
                        
                        .id(score.stats.sets)
                        .frame(width: 50, height: 60)
                        .clipped()
                    }
                    VStack {
                        Text("Reps")
                        Picker("Reps", selection: $score.stats.reps) {
                            ForEach(0..<25) { i in
                                Text("\(i)").foregroundColor(colorTheme).tag(Int(i))
                            }
                        }
                        .id(score.stats.reps)
                        .frame(width: 50, height: 60)
                        .clipped()
                    }
                    VStack {
                        Text("Weights")
                        Picker("Weights", selection: $score.stats.weight) {
                            ForEach(0..<250) { i in
                                Text("\(i)").foregroundColor(colorTheme).tag(Double(i))
                            }
                            
                        }
                        .frame(width: 50, height: 60)
                        .clipped()
                    }
                }.frame(height: 100)
            }
            
            Spacer()
            Text("Total volume: \(score.stats.volume)")
                .font(.title2)
                
        }.foregroundColor(colorTheme)
    }
}

//MARK: Detailed View
fileprivate struct DetailView: View {
    @ObservedObject var score: JBScore
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        HStack {
            //Save
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.clear)
                .shadow(color: .white, radius: 4, x: 4, y: 4)
                .overlay(
                    Button {
                        viewModel.saveScore(score: score)
                    } label: {
                        Text("Save excercise")
                            .bold()
                    }
                )
            //Delete
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.clear)
                .shadow(color: .black, radius: 4, x: 4, y: 4)
                .overlay(
                    Button {
                        viewModel.deleteScore(score: score)
                    } label: {
                        Text("Delete excercise")
                            .bold()
                    }
                )
        }.multilineTextAlignment(.center)
    }
}

struct ScoreCell_Previews: PreviewProvider {
    
    @State static var set: Int = 10
    @State static var reps: Int = 10
    @State static var weight: Double = 10
    @State static var volume: Int = 1000
    
    static var previews: some View {
        ScoreCell(score: JBScore(excercise: Excercise(), id: UUID(), stats: Stats(sets: 0, reps: 0, weight: 0)))
    }
}
