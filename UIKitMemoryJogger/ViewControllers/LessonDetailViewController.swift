import UIKit

private enum LessonDetailLayout {
    static let contentPadding: CGFloat = 24
    static let stackSpacing: CGFloat = 20
    static let cardPadding: CGFloat = 18
}

final class LessonDetailViewController: UIViewController {
    private let lesson: Lesson
    private let onToggleRemembered: (UUID) -> Void

    init(lesson: Lesson, onToggleRemembered: @escaping (UUID) -> Void) {
        self.lesson = lesson
        self.onToggleRemembered = onToggleRemembered
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = lesson.title
        view.backgroundColor = .systemGroupedBackground
        setupContent()
    }

    private func setupContent() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = LessonDetailLayout.stackSpacing
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        let summaryLabel = makeLabel(text: lesson.summary, style: .title3, color: .label)
        let reminderLabel = makeCardLabel(text: lesson.reminder)
        let checkpointViews = lesson.checkpoints.map { makeCheckpointLabel(text: $0) }
        let rememberedButton = makeRememberedButton()

        contentStack.addArrangedSubview(summaryLabel)
        contentStack.addArrangedSubview(reminderLabel)
        checkpointViews.forEach(contentStack.addArrangedSubview)
        contentStack.addArrangedSubview(rememberedButton)

        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: LessonDetailLayout.contentPadding),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: LessonDetailLayout.contentPadding),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -LessonDetailLayout.contentPadding),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -LessonDetailLayout.contentPadding)
        ])
    }

    private func makeLabel(text: String, style: UIFont.TextStyle, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: style)
        label.textColor = color
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }

    private func makeCardLabel(text: String) -> UILabel {
        let label = PaddingLabel()
        label.text = text
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.backgroundColor = .secondarySystemGroupedBackground
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.insets = UIEdgeInsets(top: LessonDetailLayout.cardPadding, left: LessonDetailLayout.cardPadding, bottom: LessonDetailLayout.cardPadding, right: LessonDetailLayout.cardPadding)
        return label
    }

    private func makeCheckpointLabel(text: String) -> UILabel {
        makeLabel(text: "• \(text)", style: .body, color: .secondaryLabel)
    }

    private func makeRememberedButton() -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = lesson.isRemembered ? "Mark as needs review" : "I remember this"
        configuration.image = UIImage(systemName: lesson.isRemembered ? "arrow.counterclockwise" : "checkmark")
        configuration.imagePadding = 8
        configuration.baseBackgroundColor = .systemTeal

        let button = UIButton(configuration: configuration)
        button.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            self.onToggleRemembered(self.lesson.id)
            self.navigationController?.popViewController(animated: true)
        }, for: .touchUpInside)
        return button
    }
}
