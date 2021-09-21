//
//  Home.swift
//  Progression
//
//  Created by Jesper Bertelsen on 26/08/2021.
//

import SwiftUI

struct Home: View {
    var currentDate: Date = Date()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        let prefLanguage = Locale.preferredLanguages[0]
        formatter.locale = Locale(identifier: prefLanguage)
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    } ()
    
    
    @EnvironmentObject var viewModel: ViewModel 
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                TopBar {
                    Button {
                        viewModel.newScoreIsActive.toggle()
                    } label: {
                        Image(systemName: "plus") 
                    }
                }
                
                Text("\(dateFormatter.string(from: currentDate).capitalized)")
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.scores, id: \.id) { score in
                        ScoreCell(score: score)
                            .padding(.bottom, 20)
                    }
                    
                }
                Spacer()
                
            }
            .blur(radius: viewModel.newScoreIsActive ? 3 : 0)
            .padding()
            if viewModel.newScoreIsActive {
                InteractionView(isActive: $viewModel.newScoreIsActive) {
                    NewScore(selectedExcercise: viewModel.excercises.first!)
                }
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
