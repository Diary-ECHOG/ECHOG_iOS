//
//  UIFontMetrics+.swift
//  echog
//
//  Created by minsong kim on 9/18/24.
//

import UIKit

extension UIFontMetrics {
    static func customFont(with name: Font.Name, of size: Font.Size, for style: UIFont.TextStyle) -> UIFont {
    let font = UIFont.changeFont(with: name, of: size)
    
    return UIFontMetrics(forTextStyle: style).scaledFont(for: font)
  }
}
