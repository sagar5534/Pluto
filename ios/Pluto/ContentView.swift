//
//  ContentView.swift
//  Pluto
//
//  Created by Sagar R Patel on 2024-12-12.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tabSelected = 0

    var body: some View {
        
        TabView(selection: $tabSelected) {
        
            NavigationStack {
                Dashboard()
            }
            .tabItem {
                Label("Dashboard", systemImage: "house")
            }
            
            NavigationStack {
                Insights()
            }
            .tabItem {
                Label("Insights", systemImage: "chart.bar")
            }
            
            NavigationStack {
                Analytics()
            }
            .tabItem {
                Label("Analytics", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90")
            }
        }

    }
}

#Preview {
    ContentView()
}
