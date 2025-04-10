//
//  SelectionButon.swift
//  echog
//
//  Created by minsong kim on 2/14/25.
//

import UIKit

final class SelectionButton: UIButton {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setImage(UIImage(systemName: "checkmark"), for: .normal)
            } else {
                self.setImage(nil, for: .normal)
            }
        }
    }
    
    init(frame: CGRect = .zero, isSelected: Bool) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.border.cgColor
        self.backgroundColor = .white
        self.tintColor = .slate800
        
        self.isSelected = isSelected
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
