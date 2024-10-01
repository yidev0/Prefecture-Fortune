//
//  MainView.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/25.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
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
                    
                    Button(role: .destructive) {
                        viewModel.resetInputs()
                    } label: {
                        Text("Label.ResetInputs")
                    }
                    .disabled(viewModel.name.isEmpty)
                }
                
                Section {
                    if viewModel.name.isEmpty {
                        HStack {
                            Spacer()
                            Text("Label.EnterInformationForFortune")
                            Spacer()
                        }
                    } else {
                        Button {
                            viewModel.fetchFortune()
                        } label: {
                            HStack(spacing: 12) {
                                Spacer()
                                Text("Button.TellFortune")
                                    .fontWeight(.semibold)
                                if viewModel.isFetching {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                }
                                Spacer()
                            }
                            .foregroundStyle(.white)
                        }
                        .listRowBackground(Color.blue)
                        .buttonStyle(.borderedProminent)
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
            .onChange(of: viewModel.fortuneResult?.id) {
                viewModel.saveHistory(context: modelContext)
            }
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    @Previewable @State var mainViewModel = MainViewModel()
    
    MainView()
        .environment(mainViewModel)
}
