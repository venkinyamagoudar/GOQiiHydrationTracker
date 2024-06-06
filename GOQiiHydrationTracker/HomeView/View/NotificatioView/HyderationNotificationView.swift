//
//  HyderationNotificationView.swift
//  GOQiiHydrationTracker
//
//  Created by Venkatesh Nyamagoudar on 6/7/24.
//

import SwiftUI

struct HyderationNotificationView: View {
    @AppStorage("notificationInterval") private var notificationInterval = 45
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.5, blue: 0.5), Color(red: 1.0, green: 0.7, blue: 0.4)]), startPoint: .top, endPoint: .bottom)
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Notification Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 30)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Notification Interval")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    HStack {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color.blue.opacity(0.3))
                        Stepper(value: $notificationInterval, in: 15...120, step: 15) {
                            Text("\(notificationInterval) minutes")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))
                        .foregroundColor(.black)
                        .accentColor(.white)
                        
                    }
                    .padding(.top, 5)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                NotificationManager.shared.scheduleIntervalNotification(interval: TimeInterval(notificationInterval * 60))
            }
        }
    }
    
    private func saveNotificationInterval(_ interval: Int) {
        notificationInterval = interval
    }
}

#Preview {
    HyderationNotificationView()
}
