import Foundation

enum LessonSeed {
    static let lessons: [Lesson] = [
        Lesson(
            title: "View Controller Lifecycle",
            category: .basics,
            summary: "Remember where setup, layout, and refresh work usually belongs.",
            reminder: "`viewDidLoad` runs once. `viewWillAppear` runs before the screen returns. Keep heavy work out of layout methods.",
            checkpoints: [
                "Create labels and buttons in `viewDidLoad`.",
                "Refresh visible data in `viewWillAppear`.",
                "Avoid network calls inside `viewDidLayoutSubviews`."
            ]
        ),
        Lesson(
            title: "Programmatic Auto Layout",
            category: .layout,
            summary: "Build screens without Storyboards using anchors and stack views.",
            reminder: "Set `translatesAutoresizingMaskIntoConstraints = false`, add the view, then activate constraints.",
            checkpoints: [
                "Add subviews before constraints.",
                "Use `NSLayoutConstraint.activate` for related constraints.",
                "Prefer `UIStackView` for vertical text groups."
            ]
        ),
        Lesson(
            title: "Reusable Table Cells",
            category: .data,
            summary: "Display a list with clean reusable cell configuration.",
            reminder: "Register the cell class once and keep cell UI updates inside a `configure` method.",
            checkpoints: [
                "Register the class with a reuse identifier.",
                "Dequeue with the same identifier.",
                "Reset or configure all visible state every time."
            ]
        ),
        Lesson(
            title: "Delegation",
            category: .basics,
            summary: "Let one object report user actions back to another object.",
            reminder: "A delegate is usually a weak reference and a protocol. UIKit uses this pattern everywhere.",
            checkpoints: [
                "Read `UITableViewDelegate` method names.",
                "Notice how selection flows from table view to controller.",
                "Use protocols when a reusable view needs to report actions."
            ]
        ),
        Lesson(
            title: "Simple View Model",
            category: .data,
            summary: "Move filtering and progress logic away from the view controller.",
            reminder: "The view model should answer questions the screen asks: what rows exist, what count is complete, and what changed.",
            checkpoints: [
                "Keep UIKit imports out of the view model.",
                "Expose small methods like `lesson(at:)`.",
                "Call a closure when the screen should reload."
            ]
        )
    ]
}
