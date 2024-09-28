//
//  MainView.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/25.
//

import SwiftUI

struct MainView: View {
    
    @State private var viewModel = MainViewModel()
    
    var body: some View {
        Form {
            Section {
                LabeledContent("Label.Name") {
                    TextField(
                        "Label.Name",
                        text: $viewModel.name
                    )
                    .multilineTextAlignment(.trailing)
                }
                
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
                    viewModel.fetchFortune()
                } label: {
                    HStack(spacing: 12) {
                        Text("Button.TellFortune")
                        
                        if viewModel.isFetching {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                    }
                }
            }
        }
        .alert(
            isPresented: $viewModel.showAlert,
            error: viewModel.alertType
        ) {
            Button("OK") {}
        }
        .sheet(item: $viewModel.fortuneResult) { result in
            ResultView(result: result)
        }
    }
}

#Preview {
    @Previewable @State var mainViewModel = MainViewModel()
    
    MainView()
        .environment(mainViewModel)
}
