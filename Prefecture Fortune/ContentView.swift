//
//  ContentView.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        TabView {
            Tab {
                MainView()
            } label: {
                Label("Tab.Fotune", systemImage: "sparkles")
            }
            
            Tab {
                HistoryView()
            } label: {
                Label("Tab.History", systemImage: "clock")
            }
        }
    }
    
}

#Preview {
    ContentView()
}
