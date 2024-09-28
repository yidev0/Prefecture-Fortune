//
//  ResultView.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/28.
//

import SwiftUI
import MapKit

struct ResultView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel: ResultViewModel
    
    init(result: FortuneResponse) {
        self.viewModel = .init(fortuneResult: result)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent("Label.PrefectureName") {
                        Text(viewModel.fortuneResult.name)
                    }
                    
                    LabeledContent("Label.CapitalName") {
                        Text(viewModel.fortuneResult.capital)
                    }
                    
                    if let citizenDay = viewModel.fortuneResult.citizenDay {
                        LabeledContent("Label.CitizenDay") {
                            Text(citizenDay.dateString)
                        }
                    }
                    
                    LabeledContent("Label.HasCoastline") {
                        Text(viewModel.fortuneResult.hasCoastLine ? "Label.Yes" : "Label.No")
                    }
                }
                
                Section {
                    AsyncImage(url: URL(string: viewModel.fortuneResult.logoUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    
                    Text(viewModel.fortuneResult.brief)
                        .foregroundStyle(.secondary)
                }
                
                Section {
                    Map(
                        position: $viewModel.cameraPosition
                    ) {
                        if let coordinate = viewModel.capitalCoordinate {
                            Marker(
                                viewModel.fortuneResult.capital,
                                coordinate: coordinate
                            )
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(alignment: .topTrailing) {
                        Button {
                            Task {
                                await viewModel.searchLocation()
                            }
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.circle)
                        .padding(8)
                        .accessibilityLabel("Label.Reset")
                    }
                    .listRowInsets(EdgeInsets())
                    
                    if let url = viewModel.makeMapURL() {
                        Link(destination: url) {
                            Text("Label.OpenInMaps")
                        }
                    }
                }
            }
            .navigationTitle("Label.FortuneResult")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Text("Label.Close")
                }

            }
            .task {
                await viewModel.searchLocation()
                await viewModel.searchCapital()
            }
        }
    }
}

#Preview {
    ResultView(result: .sample)
}
