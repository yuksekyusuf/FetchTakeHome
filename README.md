# FetchTakeHome

This project is a recipe app developed as a take-home project for Fetch.

## Steps to Run the App

1. **Clone the repository** to your local machine.
2. **Open the project in Xcode** (version 14.0 or later).
3. **Set the target device** to either a simulator or a physical iOS device (iOS 16 or later required).
4. **Run the app** by pressing `Cmd + R` or clicking the "Run" button in Xcode.
5. The app will fetch and display a list of recipes, caching images as they load.

## Focus Areas

I focused on setting up a clean architecture that separates concerns, using protocol-based dependency injection for testability. Core logic like network fetching and image caching was encapsulated in services, while the UI layer remains lightweight. Concurrency is handled with Swift’s `async/await` to avoid blocking the UI thread, and Actor isolation was used for the `CacheService` to ensure thread safety.

## Time Spent

I spent approximately **4-5 hours** on this project:
- **1.5 hours**: Setting up data models, view models, and network service layers.
- **1 hour**: Implementing caching and image loading in a separate view model.
- **1 hour**: Designing the UI and testing edge cases (e.g., empty data, malformed responses).
- **30 minutes**: Writing error handling and testing for network failures.
- **30 minutes**: Documentation, final testing, and minor UI adjustments.
  
## Trade-offs and Decisions

- **No Singleton Usage**: I avoided singletons to keep services modular and testable. This approach makes it easier to swap services or mock dependencies in tests.
- **Simplified UI**: Limited the app to a single screen, focusing more on optimizing network and image handling.

## Weakest Part of the Project

- **Testing Coverage**: Due to time constraints, I focused on testing core functionality, particularly the view model layer. Service class testing was not fully covered.
- **Error Handling**: Although the app gracefully handles empty and malformed data, complex error scenarios (e.g., network failures) were not fully tested or simulated.
- **Offline Support**: The app currently only supports in-memory caching, which limits its ability to handle offline scenarios efficiently.
