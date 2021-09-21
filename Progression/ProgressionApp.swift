//
//  ProgressionApp.swift
//  Progression
//
//  Created by Jesper Bertelsen on 26/08/2021.
//

import SwiftUI

@main
struct ProgressionApp: App {
    var coreDataHelperContext = CoreDataHelper.shared.context
    var viewModel: ViewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataHelperContext)
                .environmentObject(viewModel)
                .accentColor(.red)
        }
    }
}
