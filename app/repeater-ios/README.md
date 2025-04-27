# Slack Repeater

An iOS app that allows users to quickly save and reuse Slack messages, preserving mentions and links.

## Features

- Save content copied from Slack to reuse later
- Organize saved messages in a grid layout for easy access
- Tap on a saved message to copy it back to the clipboard
- Preserves mentions, links, and other rich formatting from the original Slack messages

## Requirements

- iOS 18.0+
- Xcode 16.0+
- Swift 6.0+

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Models:** Contains the data structures like `SavedMessage`
- **Views:** UI components like `MessageGridView` and `AddMessageView`
- **ViewModels:** Contains the business logic in `MessageViewModel`

## Implementation Notes

- Uses SwiftUI for the user interface
- Persists data using UserDefaults
- Designed following Point-Free tutorials and conventions with an emphasis on clean architecture

## Getting Started

1. Clone the repository
2. Open `Repeater.xcodeproj` in Xcode
3. Build and run the app on your device or simulator