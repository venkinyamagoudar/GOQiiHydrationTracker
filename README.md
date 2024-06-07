# HydrationTracker iOS Application

## Overview

HydrationTracker is an iOS application that helps users track their daily water intake. The application provides statistics and visualizations to encourage users to meet their hydration goals. This project includes various UI components, data models, and view models following the MVVM (Model-View-ViewModel) architecture.

### Architecture Used

The project follows a Model-View-ViewModel (MVVM) architecture pattern.

- **Model:** Includes CoreData models such as `DailyHydration` and `WaterLogEntry`.
- **View:** SwiftUI views responsible for presenting the UI components like `StatisticsView`, `CalendarDayView`, and others.
- **ViewModel:** View models such as `StatisticsViewModel` and `HomeViewModel` manage data fetching, processing, and business logic.

### Requirements

- **Xcode:** The project is developed using Xcode, Apple's integrated development environment for macOS.
- **Swift:** The programming language used for iOS app development.
- **SwiftUI:** Used for building the user interface components declaratively.
- **iOS SDK:** Required for accessing iOS system frameworks and building native iOS applications.
- **CoreData:** Used for local data storage and management.
- **UserNotifications:** Utilized for scheduling and handling local notifications.
- **Lottie:** Used to natively renders vector-based animations and art in realtime with minimal code.

### Technologies Used

- **Swift:** The primary programming language for iOS app development.
- **SwiftUI:** Apple's modern UI framework for building user interfaces across all Apple platforms.
- **CoreData:** Apple's framework for managing the model layer objects in an application.
- **UserNotifications:** Used for scheduling local notifications to remind users to drink water.
- **Combine Framework:** Used for handling asynchronous events and data flow in the MVVM architecture.

### Key Components

#### Models

1. **DailyHydration**
   - Manages daily water intake and targets.
   - Properties: `id`, `date`, `currentHydration`, `targetHydration`, `waterLogEntryList`.

2. **WaterLogEntry**
   - Represents an entry for water consumption.
   - Properties: `id`, `quantity`, `enteredTime`.

#### Views

1. **StatisticsView**
   - Displays statistics on water consumption over the past week or month.
   - Contains a segmented control to switch between weekly and monthly views.
   - Includes `StatisticsCardView` for displaying average and max hydration and `BarChartActivityView` for visualization.

2. **CalendarDayView**
   - Displays daily hydration data in a calendar format.
   - Uses the `Wave` shape to visually represent the percentage of water consumed each day.

3. **CircleWaveView**
   - Custom view with a wave animation representing the percentage of the hydration target met.

#### ViewModels

1. **StatisticsViewModel**
   - Fetches and processes data to provide statistics on water consumption.
   - Manages state for selected date range (last 7 days or last 30 days).

2. **HomeViewModel**
   - Manages daily hydration data and interacts with CoreData for data persistence.

### CoreData Manager

- **CoreDataManager**
  - Singleton class to manage CoreData stack.
  - Methods for fetching, creating, updating, and deleting hydration data.

### Notification Manager

- **NotificationManager**
  - Manages scheduling and handling local notifications.
  - Methods for requesting notification permissions, scheduling daily reminders, and achievement notifications.

### Example Code Snippets

#### StatisticsView

```swift
struct StatisticsView: View {
    @StateObject var viewModel: StatisticsViewModel = StatisticsViewModel()
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    HStack {
                        StatisticsCardView(cardType: .average, viewModel: viewModel)
                        StatisticsCardView(cardType: .max, viewModel: viewModel)
                    }
                    StatisticsCardView(cardType: .daysCompletedTarget, viewModel: viewModel)
                }
                .padding()
                Picker(selection: $viewModel.selectedIndex, label: Text("Statistics")) {
                    Text("Last 7 Days").tag(0)
                    Text("Last 30 Days").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                GeometryReader { geometry in
                    VStack {
                        if viewModel.selectedIndex == 0 {
                            if viewModel.hasLastSevenDaysData {
                                BarChartActivityView(data: viewModel.lastSevenDaysData, title: "Last 7 Days Stats", height: geometry.size.height * 0.7)
                            } else {
                                AddLottieView(lottieFileName: LottieFiles.noDataFound)
                            }
                        } else {
                            if viewModel.hasLastThirtyDays {
                                BarChartActivityView(data: viewModel.lastThirtyDaysData, title: "Previous 30 Days Stats", height: geometry.size.height * 0.7)
                            } else {
                                AddLottieView(lottieFileName: LottieFiles.noDataFound)
                            }
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.7)
                .onAppear {
                    viewModel.fetchStatistics()
                }
                .navigationTitle("Statistics")
            }
        }
    }
}
