//
//  ContentView.swift
//  cost-control
//
//  Created by Mark Nokhrin on 30.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Главная")
                }
        }
    }
}

#Preview {
    ContentView()
}
