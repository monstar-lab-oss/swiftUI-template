//
//  __cookiecutter_app_name__App.swift
//  {{cookiecutter.app_name}}
//
//  Created by Rokon on 11/9/21.
//

import SwiftUI

@main
struct __cookiecutter_app_name__App: App {
    @StateObject var viewModel = TrendingGithubViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
