//
//  ContentView.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass)
    var horizontalSizeClass
    
    @Query(sort: \FortuneData.date)
    var fortuneData: [FortuneData]
    
    @State var data = [Date: [FortuneData]]()

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
            
            if horizontalSizeClass == .regular {
                TabSection {
                    ForEach(data.keys.sorted(), id: \.self) { key in
                        TabSection {
                            ForEach(data[key] ?? []) { data in
                                Tab {
                                    ResultView(data: data)
                                } label: {
                                    HistoryCell(data: data)
                                }
                            }
                        } header: {
                            Text(key, format: .dateTime.year().month().day())
                        }
                        .tabPlacement(.sidebarOnly)
                    }
                } header: {
                    Label("Tab.History", systemImage: "clock")
                }
                .tabPlacement(.sidebarOnly)
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .onAppear {
            updateData(for: fortuneData)
        }
        .onChange(of: fortuneData) { _, newValue in
            updateData(for: newValue)
        }
    }
    
    func updateData(for data: [FortuneData]) {
        self.data = FortuneDataOrganizer().sectionze(data: data)
    }
    
}

#Preview {
    ContentView()
}
