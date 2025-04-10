//
//  SubButton.swift
//  echog
//
//  Created by minsong kim on 2/6/25.
//

import UIKit

class SubButton: UIButton {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = .slate600
            } else {
                self.backgroundColor = .actionPrimaryTonal
            }
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.titleLabel?.font = .mediumTitle13
        self.setTitleColor(.textSecondary, for: .normal)
    }
    
    convenience init(title: String, isEnabled: Bool = false) {
        self.init()
        self.setTitle(title, for: .normal)
        self.isEnabled = isEnabled
        self.isSelected = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeSetting(_ text: String, isEnabled: Bool) {
        self.setTitle(text, for: .normal)
        self.isEnabled = isEnabled
    }
}
