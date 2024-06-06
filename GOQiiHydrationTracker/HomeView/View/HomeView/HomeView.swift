//
//  HomeView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    var body: some View {
        ZStack {
            List {
                Section {
                    HStack {
                        VStack {
                            Text("Hydration Info")
                                .font(.headline).fontWeight(.bold).foregroundStyle(Color.primary).backgroundStyle(Color(uiColor: .systemBackground)).textCase(.none)
                            CarouselView(viewModel: viewModel)
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
                .background(Color(uiColor: .secondarySystemBackground))
                
                Section(header: Text("Today's Water Log").font(.headline).fontWeight(.bold).foregroundStyle(Color.primary).textCase(.none)) {
                    if let waterIntakeEntriesSet = viewModel.dailyHydration?.waterLogEntryList as? Set<WaterLogEntry> {
                        let waterIntakeEntriesArray = Array(waterIntakeEntriesSet)
                            .sorted(by: { $0.enteredTime! > $1.enteredTime! })
                        ForEach(waterIntakeEntriesArray, id: \.id) { entry in
                            WaterIntakeRow(quantity: Double(Int(entry.quantity)), timestamp: entry.enteredTime!)
                                .background(Color(uiColor: .secondarySystemGroupedBackground))
                        }
                        .onDelete { waterIntakeEntry in
                            guard let entry = waterIntakeEntry.first else { return }
                            viewModel.deleteWaterIntakeEntry(item: waterIntakeEntriesArray[entry])
                        }
                    }
                }
            }
            .background(Color(uiColor: .systemBackground))
            
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        viewModel.isShowingAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                    }
                    .background(Color.blue)
                    .cornerRadius(35)
                    .padding()
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddView) {
                AddWaterIntakeView(isPresented: $viewModel.isShowingAddView, viewModel: viewModel)
                    .presentationDetents([.medium])
                    .presentationBackgroundInteraction(.disabled)
            }
            .onAppear {
                viewModel.createDailyHydrationIfNeeded(for: Date())
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Hydration Tracker")
            .navigationBarItems(trailing: Button(action: {
                viewModel.isNotificationSettingsPresented.toggle()
            }) {
                Image(systemName: "bell")
            })
            .sheet(isPresented: $viewModel.isNotificationSettingsPresented) {
                HyderationNotificationView()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
