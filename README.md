BudgetTrackerApp
A comprehensive iOS application for managing personal finances, tracking expenses, and achieving financial goals. Built with UIKit and SwiftUI, following MVVM architecture.
Features

📊 Dashboard with financial overview
💰 Income and expense tracking
🎯 Financial goal setting and tracking
📈 Multiple chart visualizations (Pie, Bar, Line, Area charts)
🔐 Secure authentication system
💳 Bank card and account management
📱 Intuitive user interface
🔄 Real-time data synchronization

Technologies Used

UIKit & SwiftUI: Hybrid approach for UI development (50/50 split)
Firebase: Backend services and authentication
MVVM: Architecture pattern
Charts: Custom implementation for financial data visualization
Core Data: Local data persistence
GoogleService: Analytics and performance monitoring

Requirements

iOS 15.0+
Xcode 13.0+
Swift 5.5+
CocoaPods or Swift Package Manager

Dependencies

Firebase (11.7.0)
NavigationKit
abseil (1.202401602.0)
AppCheck (11.2.0)
GoogleAppMeasurement (11.7.0)
GoogleDataTransport (10.1.0)
GoogleUtilities (8.0.2)
gRPC (1.65.1)
GTMSessionFetcher (4.2.0)
InteropForGoogle (100.0.0)
leveldb (1.22.5)
nanopb (2.30910.0)
Promises (2.4.0)
SwiftProtobuf (1.28.2)

Installation

Clone the repository
git clone https://github.com/yourusername/BudgetTrackerApp.git

bash
pod install

Open BudgetTrackerApp.xcworkspace in Xcode
Configure Firebase

Add your GoogleService-Info.plist
Enable necessary Firebase services in console


Build and run the project

Project Structure

BudgetTrackerApp/
├── App/
│   └── Resources/
│       ├── Assets
│       └── LaunchScreen
├── Core/
│   └── Extensions/
│       ├── Codable+Dictionary
│       └── ColorExtensions
├── Data/
│   ├── Services/
│   │   └── FirebaseConfig/
│   └── MockData/
├── Features/
│   ├── Authentication/
│   ├── Dashboard/
│   ├── Budget/
│   ├── Transactions/
│   └── Charts/
└── Navigation/

Architecture
The app follows MVVM (Model-View-ViewModel) architecture:

Models: Data structures and business logic
Views: UI components (UIKit and SwiftUI)
ViewModels: Business logic and data handling
Services: Firebase integration and data management

Features in Detail
Authentication

Secure sign-up and login
Firebase Authentication integration
Password reset functionality

Dashboard

Financial overview
Category-wise expense breakdown
Quick actions menu
Multiple chart visualizations

Budget Management

Goal setting and tracking
Expense categorization
Transaction history
Custom budget periods

Charts and Analytics

Multi-line charts for trend analysis
Area charts for cumulative data
Pie charts for expense distribution
Bar charts for comparative analysis

Contact
Your Name - jishkarianitiko@gmail.com
Project Link: [https://github.com/[yourusername](https://github.com/TinaTinaJ)/BudgetTrackerApp](https://github.com/TinaTinaJ/BudgetTrackerApp)

Acknowledgments

Firebase Documentation
Apple SwiftUI Documentation
