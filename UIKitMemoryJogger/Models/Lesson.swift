import Foundation

struct Lesson: Equatable {
    enum Category: String, CaseIterable {
        case basics = "Basics"
        case layout = "Layout"
        case data = "Data"
    }

    let id: UUID
    let title: String
    let category: Category
    let summary: String
    let reminder: String
    let checkpoints: [String]
    var isRemembered: Bool

    init(
        id: UUID = UUID(),
        title: String,
        category: Category,
        summary: String,
        reminder: String,
        checkpoints: [String],
        isRemembered: Bool = false
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.summary = summary
        self.reminder = reminder
        self.checkpoints = checkpoints
        self.isRemembered = isRemembered
    }
}
