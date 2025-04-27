## Overview:
This app allows users to quickly save and reuse text snippets, including Slack messages and login credentials, preserving formatting when needed.

## Requirements:

### Slack Messages
- When the Add button is pressed, an input field should appear where users can paste content copied from Slack.
- Each saved message should be represented as a button inside a Grid layout.
- Pressing a message button should copy the corresponding message back to the clipboard.
- Mentions, links, and other rich formatting from the original Slack message must be preserved exactly when saving and copying.

### Login Credentials
- Users should be able to save email and password pairs.
- When adding credentials, two input fields should be presented: one for the email and one for the password.
- Each saved credential pair should be represented as a button inside a Grid layout.
- Each credential item should have two separate buttons for copying: one for the email and one for the password.
- The password should be displayed in a masked format (dots or asterisks) for security.
- Swipe to delete functionality should be available for all saved items.
