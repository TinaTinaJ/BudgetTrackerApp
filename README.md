# BudgetTrackerApp

A comprehensive iOS application for managing personal finances, tracking expenses, and achieving financial goals. Built with UIKit and SwiftUI, following MVVM architecture.

## 🌟 Features

• 📊 Dashboard with financial overview  
• 💰 Income and expense tracking  
• 🎯 Financial goal setting and tracking  
• 📈 Multiple chart visualizations (Pie, Bar, Line, Area charts)  
• 🔐 Secure authentication system  
• 💳 Bank card and account management  
• 📱 Intuitive user interface  
• 🔄 Real-time data synchronization  

📱 Screenshots

<img width="205" alt="Screenshot 2025-02-01 at 01 25 08" src="https://github.com/user-attachments/assets/b547b709-ddb2-4aed-bddd-f49a6fb2c745" />, <img width="207" alt="Screenshot 2025-02-01 at 01 25 32" src="https://github.com/user-attachments/assets/381c2479-4064-4dd7-9a9a-267fa5bb0e51" />, <img width="208" alt="Screenshot 2025-02-01 at 01 25 52" src="https://github.com/user-attachments/assets/628a2fe3-0893-4743-a882-77c62728a0be" />, <img width="199" alt="Screenshot 2025-02-01 at 01 26 14" src="https://github.com/user-attachments/assets/2d9072b8-604e-4c74-9fb8-b58c964efd27" />










## 🛠 Technologies Used

• **UIKit & SwiftUI**: Hybrid approach for UI development (50/50 split)  
• **Firebase**: Backend services and authentication  
• **MVVM**: Architecture pattern  
• **Charts**: Custom implementation for financial data visualization  
• **Core Data**: Local data persistence  
• **GoogleService**: Analytics and performance monitoring  

## ⚙️ Requirements

• iOS 15.0+  
• Xcode 13.0+  
• Swift 5.5+  
• CocoaPods or Swift Package Manager  

## 📦 Dependencies

• Firebase (11.7.0)  
• NavigationKit  
• abseil (1.202401602.0)  
• AppCheck (11.2.0)  
• GoogleAppMeasurement (11.7.0)  
• GoogleDataTransport (10.1.0)  
• GoogleUtilities (8.0.2)  
• gRPC (1.65.1)  
• GTMSessionFetcher (4.2.0)  
• InteropForGoogle (100.0.0)  
• leveldb (1.22.5)  
• nanopb (2.30910.0)  
• Promises (2.4.0)  
• SwiftProtobuf (1.28.2)  

## 🚀 Installation

1. Clone the repository
```bash
git clone https://github.com/TinaTinaJ/BudgetTrackerApp.git
```

2. Install dependencies
```bash
pod install
```

3. Open BudgetTrackerApp.xcworkspace in Xcode

4. Configure Firebase:
   - Add your GoogleService-Info.plist
   - Enable necessary Firebase services in console

5. Build and run the project

## 📁 Project Structure

```
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
```

## 🏗 Architecture (MVVM)

• **Models**
  - Data structures
  - Business logic
  - Data validation

• **Views**
  - UIKit components
  - SwiftUI views
  - Custom UI elements

• **ViewModels**
  - Business logic
  - Data formatting
  - State management

• **Services**
  - Firebase integration
  - Data persistence
  - API communication

## 📱 Features In Detail

### 🔐 Authentication
• Secure sign-up and login  
• Firebase Authentication integration  
• Password reset functionality  

### 📊 Dashboard
• Financial overview  
• Category-wise expense breakdown  
• Quick actions menu  
• Multiple chart visualizations  

### 💰 Budget Management
• Goal setting and tracking  
• Expense categorization  
• Transaction history  
• Custom budget periods  

### 📈 Charts and Analytics
• Multi-line charts for trend analysis  
• Area charts for cumulative data  
• Pie charts for expense distribution  
• Bar charts for comparative analysis  


## 📞 Contact

Your Name - Tiko Jishkariani 
Email - jishkarianitiko@gmail.com

Project Link: https://github.com/TinaTinaJ/BudgetTrackerApp.git

## 🙏 Acknowledgments

• Firebase Documentation  
• Apple SwiftUI Documentation  
• iOS Development Community
