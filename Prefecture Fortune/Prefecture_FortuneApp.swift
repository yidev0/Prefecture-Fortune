//
//  Prefecture_FortuneApp.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/24.
//

import SwiftUI
import SwiftData

@main
struct Prefecture_FortuneApp: App {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([FortuneData.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
    
}
