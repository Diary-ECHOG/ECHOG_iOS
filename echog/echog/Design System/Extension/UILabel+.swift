//
//  UILabel+.swift
//  echog
//
//  Created by minsong kim on 1/25/25.
//

import UIKit

extension UILabel {
    func setTextWithLineSpacing(_ text: String, font: UIFont, lineSpacing: CGFloat, alinment: NSTextAlignment = .center, color: UIColor = .gray900) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alinment
        
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: font,
                .foregroundColor: color.cgColor
            ]
        )
        
        self.attributedText = attributedString
    }
}
