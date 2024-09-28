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
            
            if let result = viewModel.fortuneResult {
                Section {
                    LabeledContent("Label.PrefectureName") {
                        Text(result.name)
                    }
                    
                    LabeledContent("Label.CapitalName") {
                        Text(result.name)
                    }
                    
                    if let citizenDay = result.citizenDay {
                        LabeledContent("Label.CitizenDay") {
                            Text("Date.\(citizenDay.month).\(citizenDay.day)")
                        }
                    }
                    
                    LabeledContent("Label.HasCoastline") {
                        Text(result.hasCoastLine ? "Label.Yes" : "Label.No")
                    }
                    
                    AsyncImage(url: URL(string: result.logoUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    
                    Text(result.brief)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .alert(
            isPresented: $viewModel.showAlert,
            error: viewModel.alertType
        ) {
            Button("OK") {}
        }
    }
}

#Preview {
    @Previewable @State var mainViewModel = MainViewModel()
    
    MainView()
        .environment(mainViewModel)
}
