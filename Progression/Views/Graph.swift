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

fileprivate struct GraphView: View {
    @EnvironmentObject var viewModel: ViewModel
    var width: CGFloat
    var height: CGFloat
    var padding: CGFloat
    var bottomBorderHeight: CGFloat { return height * 0.1 }
    var topBorderHeight: CGFloat { return height * 0.1 }
    var graphHeight: CGFloat { return height - (bottomBorderHeight + topBorderHeight)}
    var graphWidth: CGFloat { return width - padding*2 }
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short
        return formatter
    } ()
    
    var graphScores: [Score] {
        guard let excercise = viewModel.currentExcercise else { return [] }
        guard let scores = excercise.scores?.allObjects as? [Score] else { return [] }
        let sorted = scores.sorted(by: { $0.date < $1.date} )
        return sorted
    }
    var enhancedAccentColor: Color {
        var (h,s,b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0, 0.0)
        let accent = UIColor(Color.accentColor)
        accent.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        let color = UIColor(hue: h, saturation: s, brightness: b, alpha: a)
        return Color(color)
    }
    var gradient: Gradient { Gradient(colors: [.accentColor.opacity(0.4),
                                               .accentColor.opacity(0.6)]) }
    var body: some View {
        ZStack {
//            makeLines()
//                .stroke(lineWidth: 2)
//                .foregroundColor(.black).opacity(0.4)
            makePoints()
                .stroke(lineWidth: 4)
                .foregroundColor(.accentColor)
                .saturation(0.4)
                .brightness(0.6)
            ForEach(0..<graphScores.count, id: \.self) { i in
                makeDot(point: i)
                    .foregroundColor(.accentColor)
                    .saturation(0.8)
                    .brightness(viewModel.detailedScore.id == graphScores[i].id && viewModel.detailViewIsActive ? 0.2 : 0.4)
                    .onTapGesture {
                        viewModel.detailedScore = graphScores[i].convertToJBScore()
                        viewModel.detailViewIsActive.toggle()
                    }
            }
            makeLabels()
                .foregroundColor(.white)
        }
        
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.accentColor)
                .opacity(0.6)
                .saturationFade(0.5, startPoint: .leading, endPoint: .trailing)
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
    private func makeDot(point at: Int) -> Path {
        let size: CGFloat = 20
        let x = columnXPoint(point: at) - size / 2
        let y = columnYPoint(value: CGFloat(graphScores[at].volume)) - size / 2
        let path = Path(ellipseIn: CGRect(x: x, y: y, width: size, height: size))
        return path
    }
    private func makePoints() -> Path {
        var path = Path()
        path.move(to: CGPoint(x: padding, y: height-bottomBorderHeight))
        for i in 0..<graphScores.count {
            let x = columnXPoint(point: i)
            let y = columnYPoint(value: CGFloat(graphScores[i].volume))
            let point = CGPoint(x: x, y: y)
            print("Point: \n \(point) \n")
            path.addLine(to: point)
        }
        return path
    }
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
    
    private func columnXPoint(point: Int) -> CGFloat {
        let percentage = CGFloat(point + 1) / CGFloat(graphScores.count)
        
        let value = graphWidth * percentage
        
        return value
    }
    private func columnYPoint(value: CGFloat) -> CGFloat {
        guard let maxValue = graphScores.map({$0.volume}).max() else { return 0 }
        let value = graphHeight + bottomBorderHeight - (graphHeight * (value / CGFloat(maxValue)))
        return value
    }
}
struct Graph_Previews: PreviewProvider {
    static var previews: some View {
        Graph()
    }
}
