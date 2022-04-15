//
//  MainView.swift
//  AwesomeApp
//
//  Created by Rokon on 11/9/21.
//

import SwiftUI

struct MainView: View {
   
    var body: some View {
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
        .padding(.top, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
