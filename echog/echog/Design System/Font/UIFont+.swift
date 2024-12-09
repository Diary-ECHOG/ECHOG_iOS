//
//  UIFont+.swift
//  echog
//
//  Created by minsong kim on 9/18/24.
//

import Foundation

import UIKit

extension UIFont {
    static func changeFont(with name: Font.Name, of size: Font.Size) -> UIFont {
        guard let font = UIFont(name: name.file, size: size.rawValue) else {
            return .systemFont(ofSize: size.rawValue)
        }
        return font
    }
}

extension UIFont {
    static var semiboldHeadline24: UIFont {
        return UIFontMetrics.customFont(with: .pretendardSemiBold, of: ._24, for: .headline)
    }
    
    static var semiboldSubheadline22: UIFont {
        return UIFontMetrics.customFont(with: .pretendardSemiBold, of: ._22, for: .subheadline)
    }
    
    static var semiboldLargetitle17: UIFont {
        return UIFontMetrics.customFont(with: .pretendardSemiBold, of: ._17, for: .largeTitle)
    }
    
    static var semiboldTitle15: UIFont {
        return UIFontMetrics.customFont(with: .pretendardSemiBold, of: ._15, for: .title1)
    }
    
    static var mediumTitle15: UIFont {
        return UIFontMetrics.customFont(with: .pretendardMedium, of: ._15, for: .title1)
    }
    
    static var regularTitle15: UIFont {
        return UIFontMetrics.customFont(with: .pretendardRegular, of: ._15, for: .title1)
    }
    
    static var semiboldTitle14: UIFont {
        return UIFontMetrics.customFont(with: .pretendardSemiBold, of: ._14, for: .title2)
    }
    
    static var mediumTitle14: UIFont {
        return UIFontMetrics.customFont(with: .pretendardMedium, of: ._14, for: .title2)
    }
    
    static var regularTitle14: UIFont {
        return UIFontMetrics.customFont(with: .pretendardRegular, of: ._14, for: .title2)
    }
    
    static var semiboldTitle13: UIFont {
        return UIFontMetrics.customFont(with: .pretendardSemiBold, of: ._13, for: .title3)
    }
    
    static var mediumTitle13: UIFont {
        return UIFontMetrics.customFont(with: .pretendardMedium, of: ._13, for: .title3)
    }
    
    static var regularTitle13: UIFont {
        return UIFontMetrics.customFont(with: .pretendardRegular, of: ._13, for: .title3)
    }
}
