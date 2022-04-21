//
//  MainView.swift
//  {{cookiecutter.app_name}}
//
//  Created by Rokon on 11/9/21.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        HStack {
            // Use image using R.swift
            R.image.fork_icon.image
            Text("Title")
        }
        TabView {
            TrendingRepositoryView()
                .tabItem {
                    Label("Repositories", systemImage: "book.closed.fill")
                }
            
            TrendingDeveloperView()
                .tabItem {
                    Label("Developers", systemImage: "person.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
