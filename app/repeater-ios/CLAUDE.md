# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Test Commands
- Build: `xcodebuild -project Repeater.xcodeproj -scheme Repeater build`
- Test: `xcodebuild -project Repeater.xcodeproj -scheme Repeater test`
- Run single test: `xcodebuild -project Repeater.xcodeproj -scheme Repeater test -only-testing:RepeaterTests/TestClassName/testMethodName`
- Preview SwiftUI: Use Xcode Preview canvas or run in simulator

## Code Style Guidelines
- Follow Apple Swift style guide - 2 space indentation
- Import statements at the top, grouped by framework (SwiftUI first)
- Use Swift's strong typing system with proper type annotations
- Naming: camelCase for variables/functions, PascalCase for types
- Group related functionality with extensions
- Use Swift's Result type for error handling
- SwiftUI components should be in their own files
- Use Swift concurrency (async/await) for asynchronous code
- Comment new files using the standard header format
- Use SwiftUI previews for visual components
