//
//  AddWaterIntakeView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct AddWaterIntakeView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: HomeViewModel
    @State var numberOfGlasses: Int = 0
    @State private var showAlert = false
    
    private let formatter = DateFormatter()
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    Button(action: {
                        if numberOfGlasses > 0 {
                            numberOfGlasses -= 1
                        }
                    }) {
                        Image(systemName: "minus")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                    }
                    .background(Color.blue)
                    .cornerRadius(35)
                    .padding()
                    ZStack {
                        Text("\(numberOfGlasses)")
                            .font(.title)
                            .fontWeight(.bold)
                        Image(systemName: "drop")
                            .resizable()
                            .foregroundStyle(Color.blue.opacity(0.3))
                            .frame(width: 100,height: 150)
                    }
                    .padding(.vertical)
                    
                    Button(action: {
                        numberOfGlasses += 1
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                    }
                    .background(Color.blue)
                    .cornerRadius(35)
                    .padding()
                }
                
                Button(action: {
                    if numberOfGlasses > 0 {
                        viewModel.updateCurrentHydration(amount: Int16(numberOfGlasses))
                        
                        viewModel.addWaterIntakeEntry(numberOfGlasses: numberOfGlasses)
                        isPresented = false
                    } else {
                        showAlert = true
                    }
                }) {
                    Text("Add")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding()
            .navigationTitle("Log Water intake")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Cannot Add 0 Glasses", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

#Preview {
    AddWaterIntakeView(isPresented: .constant(true), viewModel: HomeViewModel())
}
