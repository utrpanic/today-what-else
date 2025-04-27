## Overview:
This app allows users to quickly save and reuse text snippets, including Slack messages and login credentials, preserving formatting when needed.

## Requirements:

### General UI
- Both sections (Slack Messages and Login Credentials) should be displayed on a single screen, one after another.
- Each section should have its own heading and Add button.
- Grid items should be wide enough to display content clearly (about 280pt minimum width).
- A "copied to clipboard" alert should appear when content is copied.
- Each section should have its own Reorder button that toggles an edit mode.
- In edit mode, items should be displayed in a list view with drag handles for reordering.
- Users should be able to customize the order of items within each section.
- Context menu options should be available for editing and deleting items.

### Slack Messages
- When the Add button is pressed, an input field should appear where users can paste content copied from Slack.
- Each saved message should be represented as a button inside a Grid layout.
- Pressing a message button should copy the corresponding message back to the clipboard.
- Mentions, links, and other rich formatting from the original Slack message must be preserved exactly when saving and copying.
- Users should be able to reorder messages to prioritize frequently used ones.
- Users should be able to edit existing messages by accessing the context menu.

### Login Credentials
- Users should be able to save email and password pairs.
- When adding credentials, two input fields should be presented: one for the email and one for the password.
- Each saved credential pair should be represented as a card inside a Grid layout.
- Each credential item should have two separate buttons for copying: one for the email and one for the password.
- The password should be displayed in a masked format (dots or asterisks) for security.
- Context menu functionality should be available for editing and deleting credentials.
- Users should be able to reorder credentials to prioritize frequently used ones.

### Data Storage
- All data should be persistently stored using SwiftData.
- Each item should maintain its customized order across app launches.
- Edits to existing items should be saved and persisted immediately.
