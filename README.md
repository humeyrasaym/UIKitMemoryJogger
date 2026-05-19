# UIKit Memory Jogger

UIKit Memory Jogger is a small portfolio app for restarting iOS development after a break. It is intentionally built with UIKit and programmatic layout so the code demonstrates practical iOS fundamentals without Storyboards.

## What it shows

- `UINavigationController` and push navigation.
- `UITableView` with a custom reusable cell.
- `UISegmentedControl` filtering.
- Programmatic Auto Layout.
- A small MVVM-style view model.
- Clean folders for app setup, models, data, view models, views, and view controllers.

## Folder Map

- `UIKitMemoryJogger/App`: App and scene lifecycle.
- `UIKitMemoryJogger/Models`: Plain Swift data types.
- `UIKitMemoryJogger/Data`: Seed lessons for the first version.
- `UIKitMemoryJogger/ViewModels`: Screen state and filtering logic.
- `UIKitMemoryJogger/Views`: Reusable UIKit views.
- `UIKitMemoryJogger/ViewControllers`: Screens.
- `UIKitMemoryJogger/Utilities`: Tiny UIKit helpers.

## Run

Open `UIKitMemoryJogger.xcodeproj` in Xcode and press `Cmd + R`.

## Practice Roadmap

1. Add local persistence for remembered topics.
2. Add a form screen to create custom reminders.
3. Add search.
4. Add unit tests for the view model.
5. Add a small app icon and screenshots for the GitHub README.
