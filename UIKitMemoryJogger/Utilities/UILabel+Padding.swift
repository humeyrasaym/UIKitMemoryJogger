import UIKit

final class PaddingLabel: UILabel {
    var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetBounds = bounds.inset(by: insets)
        var textRect = super.textRect(forBounds: insetBounds, limitedToNumberOfLines: numberOfLines)
        textRect.origin.x -= insets.left
        textRect.origin.y -= insets.top
        textRect.size.width += insets.left + insets.right
        textRect.size.height += insets.top + insets.bottom
        return textRect
    }
}
