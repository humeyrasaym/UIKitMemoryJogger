import Foundation

final class LessonListViewModel {
    enum Filter: Int, CaseIterable {
        case all
        case basics
        case layout
        case data

        var title: String {
            switch self {
            case .all:
                "All"
            case .basics:
                Lesson.Category.basics.rawValue
            case .layout:
                Lesson.Category.layout.rawValue
            case .data:
                Lesson.Category.data.rawValue
            }
        }

        var category: Lesson.Category? {
            switch self {
            case .all:
                nil
            case .basics:
                .basics
            case .layout:
                .layout
            case .data:
                .data
            }
        }
    }

    var onChange: (() -> Void)?

    private var lessons: [Lesson]
    private(set) var selectedFilter: Filter = .all

    init(lessons: [Lesson]) {
        self.lessons = lessons
    }

    var rememberedCount: Int {
        lessons.filter(\.isRemembered).count
    }

    var totalCount: Int {
        lessons.count
    }

    var progressText: String {
        "\(rememberedCount)/\(totalCount) remembered"
    }

    var progress: Float {
        guard totalCount > 0 else { return 0 }
        return Float(rememberedCount) / Float(totalCount)
    }

    var visibleLessons: [Lesson] {
        guard let category = selectedFilter.category else { return lessons }
        return lessons.filter { $0.category == category }
    }

    func setFilter(index: Int) {
        selectedFilter = Filter(rawValue: index) ?? .all
        onChange?()
    }

    func lesson(at index: Int) -> Lesson {
        visibleLessons[index]
    }

    func toggleRemembered(lessonID: UUID) {
        guard let index = lessons.firstIndex(where: { $0.id == lessonID }) else { return }
        lessons[index].isRemembered.toggle()
        onChange?()
    }
}
