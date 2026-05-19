import UIKit

final class LessonCell: UITableViewCell {
    static let reuseIdentifier = "LessonCell"

    private let titleLabel = UILabel()
    private let summaryLabel = UILabel()
    private let badgeLabel = UILabel()
    private let rememberedImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with lesson: Lesson) {
        titleLabel.text = lesson.title
        summaryLabel.text = lesson.summary
        badgeLabel.text = lesson.category.rawValue
        rememberedImageView.image = UIImage(systemName: lesson.isRemembered ? "checkmark.circle.fill" : "circle")
        rememberedImageView.tintColor = lesson.isRemembered ? .systemTeal : .tertiaryLabel
    }

    private func setupView() {
        accessoryType = .disclosureIndicator
        backgroundColor = .secondarySystemGroupedBackground
        selectionStyle = .none

        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.adjustsFontForContentSizeCategory = true

        summaryLabel.font = .preferredFont(forTextStyle: .subheadline)
        summaryLabel.textColor = .secondaryLabel
        summaryLabel.numberOfLines = 0
        summaryLabel.lineBreakMode = .byWordWrapping
        summaryLabel.adjustsFontForContentSizeCategory = true

        badgeLabel.font = .preferredFont(forTextStyle: .caption1)
        badgeLabel.textColor = .systemTeal
        badgeLabel.numberOfLines = 1

        rememberedImageView.setContentHuggingPriority(.required, for: .horizontal)

        let textStack = UIStackView(arrangedSubviews: [titleLabel, summaryLabel, badgeLabel])
        textStack.axis = .vertical
        textStack.spacing = 6
        textStack.setContentCompressionResistancePriority(.required, for: .vertical)

        let rowStack = UIStackView(arrangedSubviews: [textStack, rememberedImageView])
        rowStack.alignment = .center
        rowStack.spacing = 12
        rowStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(rowStack)
        NSLayoutConstraint.activate([
            rowStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            rowStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rowStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rowStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
    }
}
