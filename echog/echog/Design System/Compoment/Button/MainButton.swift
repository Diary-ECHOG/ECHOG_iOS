//
//  MainButton.swift
//  echog
//
//  Created by minsong kim on 9/18/24.
//

import UIKit

class MainButton: UIButton {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.titleLabel?.font = .semiboldLargetitle17
    }
    
    convenience init(title: String) {
        self.init()
        self.backgroundColor = .black
        self.setTitleColor(.background1, for: .normal)
        self.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
