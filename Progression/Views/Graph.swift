//
//  Graph.swift
//  Progression
//
//  Created by Jesper Bertelsen on 08/09/2021.
//
import Foundation
import SwiftUI

struct Graph: View {
    var body: some View {
        GeometryReader { geo in
            GraphView(width: geo.size.width, height: geo.size.height, padding: 20)
        }
    }
}

//MARK: GraphDetails
fileprivate struct GraphView: View {
    @EnvironmentObject var viewModel: ViewModel
    var width: CGFloat
    var height: CGFloat
    var padding: CGFloat
    var bottomBorderHeight: CGFloat { padding * 2 }
    var topBorderHeight: CGFloat = 60
    var graphHeight: CGFloat { return height - (bottomBorderHeight + topBorderHeight)}
    var graphWidth: CGFloat { return width - padding*2 }
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short
        return formatter
    } ()
    var graphScores: [Score] {
        guard let exercise = viewModel.currentExercise else { return [] }
        guard let scores = exercise.scores?.allObjects as? [Score] else { return [] }
        let sorted = scores.sorted(by: { $0.date < $1.date} )
        return sorted
    }
    
    var body: some View {
        ZStack {
//            makeLines()
//                .stroke(lineWidth: 2)
//                .foregroundColor(.black).opacity(0.4)
            makePoints()
                .stroke(lineWidth: 4)
                .secondaryOppositeColorSetting()
            ForEach(0..<graphScores.count, id: \.self) { i in
                makeDot(point: i)
                    .primaryOppositeColorSetting()
                    .onTapGesture {
                        viewModel.detailedScore = graphScores[i].convertToJBScore()
                        viewModel.detailViewIsActive.toggle()
                    }
            }
            makeLabels()
                .foregroundColor(.black)
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .secondaryColorSetting()
        )
    }
    private func makeLabels() -> some View {
        return ZStack {
            ForEach(0..<graphScores.count, id: \.self) { score in
                let x = columnXPoint(point: score)
                Text("\(graphScores[score].volume)").position(x: x, y: height - padding)
            }
        }
    }
    //MARK: Dots
    private func makeDot(point at: Int) -> Path {
        let size: CGFloat = 20
        let x = columnXPoint(point: at) - size / 2
        let y = columnYPoint(value: CGFloat(graphScores[at].volume)) - size / 2
        let path = Path(ellipseIn: CGRect(x: x, y: y, width: size, height: size))
        return path
    }
    //MARK: The line path
    private func makePoints() -> Path {
        var path = Path()
        if oneGraphscore() {
            path.move(to: CGPoint(x: padding, y: height-bottomBorderHeight))
        } else {
            path.move(to: CGPoint(x: padding*2, y: columnYPoint(value: CGFloat(graphScores[0].volume))))
        }
        for i in 0..<graphScores.count {
            let x = columnXPoint(point: i)
            let y = columnYPoint(value: CGFloat(graphScores[i].volume))
            let point = CGPoint(x: x, y: y)
            path.addLine(to: point)
        }
        return path
    }
    //MARK: Line seperators
    private func makeLines() -> Path {
        let average: CGFloat = {
            var number: CGFloat = 0
            for i in graphScores {
                number += CGFloat(i.volume)
            }
            return number / CGFloat(graphScores.count)
        }()
        var path = Path()
        path.move(to: CGPoint(x: 0, y: topBorderHeight))
        path.addLine(to: CGPoint(x: width, y: topBorderHeight))
        
        path.move(to: CGPoint(x: 0, y: columnYPoint(value: average)))
        path.addLine(to: CGPoint(x: width, y: columnYPoint(value: average)))
        
        path.move(to: CGPoint(x: 0, y: height-bottomBorderHeight))
        path.addLine(to: CGPoint(x: width, y: height-bottomBorderHeight))
        return path
    }
    //MARK: X Calculator
    private func columnXPoint(point: Int) -> CGFloat {
        let percentage = CGFloat(point + 1) / CGFloat(graphScores.count)
        let value = point > 0 || oneGraphscore() ?  graphWidth * percentage : padding*2
        return value
    }
    //MARK: Y Calculator
    private func columnYPoint(value: CGFloat) -> CGFloat {
        guard let maxValue = graphScores.map({$0.volume}).max() else { return 0 }
        guard let minValue = graphScores.map( {$0.volume}).min() else { return 0 }
        let range = maxValue - minValue
        let progression = value - CGFloat(minValue)
        guard range != 0 else { return graphHeight + bottomBorderHeight - (graphHeight * CGFloat(minValue) / CGFloat(maxValue))}
        
        let value = graphHeight+bottomBorderHeight - (graphHeight * progression / CGFloat(range))
        return value
    }
    // MARK: Bools
    
    private func oneGraphscore() -> Bool {
        if graphScores.count == 1 { return true
        } else { return false }
    }
}
struct Graph_Previews: PreviewProvider {
    static var previews: some View {
        Graph()
    }
}
