//
//  covid_swiftuiApp.swift
//  covid-swiftui
//
//  Created by Maciej Gorecki on 06/10/2020.
//

import SwiftUI

@main
struct covid_swiftuiApp: App {
    let factory = Factory()
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: factory.viewModels.home)
        }
    }
}
