//
//  EditTargetView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/6/24.
//

import SwiftUI

struct EditTargetView: View {
    @Binding var isPresented: Bool
    @State private var showAlert = false
    @State private var targetHydration = 0
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Stepper("Target Hydration: \(targetHydration) \(targetHydration == 1 ? "glass" : "glasses")", value: $targetHydration, in: 0...Int.max)
                    .padding()
                
                Button(action: {
                    viewModel.updateHydrationTarget(target: targetHydration)
                    isPresented = false
                }) {
                    Text("Save")
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
            .navigationTitle("Edit Hydration Target")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Cannot Set 0 Glasses as target", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        .onAppear {
            targetHydration = Int(viewModel.dailyHydration?.targetHydration ?? 0)
        }
    }
}

#Preview {
    EditTargetView(isPresented: .constant(true), viewModel: HomeViewModel())
}
