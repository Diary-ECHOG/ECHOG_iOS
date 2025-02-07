//
//  MainButton.swift
//  echog
//
//  Created by minsong kim on 9/18/24.
//

import UIKit

class MainButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = .black
                self.setTitleColor(.white, for: .normal)
            } else {
                self.backgroundColor = .slate400
                self.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = .slate600
            } else {
                self.backgroundColor = .black
            }
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.titleLabel?.font = .semiboldLargetitle17
    }
    
    convenience init(title: String, isEnabled: Bool = true) {
        self.init()
        self.isEnabled = isEnabled
        self.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
