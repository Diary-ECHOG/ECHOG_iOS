//
//  ChipLabel.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import UIKit

final class ChipLabel: UILabel {
    private var padding = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)

    convenience init(text: String, padding: UIEdgeInsets = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)) {
        self.init()
        self.padding = padding
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.backgroundColor = .slate100
        self.textColor = .slate800
        self.text = text
        self.font = .semiboldTitle13
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
