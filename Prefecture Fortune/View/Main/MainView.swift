//
//  MainView.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/25.
//

import SwiftUI

struct MainView: View {
    
    @Environment(MainViewModel.self) private var viewModel
    
    var body: some View {
        @State var viewModel = viewModel
        
        Form {
            Section {
                TextField("Label.Name", text: $viewModel.name)
                
                DatePicker(
                    selection: $viewModel.birthday,
                    displayedComponents: .date
                ) {
                    Text("Label.Birthday")
                }
                
                Picker(selection: $viewModel.bloodType) {
                    ForEach(BloodType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                } label: {
                    Text("Label.BloodType")
                }
            }
            
            Section {
                Button {
                    
                } label: {
                    Text("Button.TellFortune")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var mainViewModel = MainViewModel()
    
    MainView()
        .environment(mainViewModel)
}
