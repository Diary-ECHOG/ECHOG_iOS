//
//  VoteSelectLineView.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import UIKit
import SnapKit

//투표 항목 선택 버튼
class VoteSelectLineView: UIView {
    private let selectButton: UIButton = {
        let button = UIButton(type: .custom)
        // 미선택 이미지 (빈 원)
        button.setImage(UIImage(resource: .isNotSelected), for: .normal)
        // 선택 이미지 (채워진 원)
        button.setImage(UIImage(resource: .isSelected), for: .selected)
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .mediumTitle13
        label.textColor = .slate800
        
        return label
    }()
    
    convenience init(frame: CGRect = .zero, title: String, index: Int) {
        self.init(frame: frame)
        self.backgroundColor = .slate25
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        self.titleLabel.text = title
        self.selectButton.tag = index
        
        configureUI()
    }
    
    private func configureUI() {
        self.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        self.addSubview(selectButton)
        self.addSubview(titleLabel)
        
        selectButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.height.width.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(selectButton.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }
    
//    // MARK: - 버튼 선택 액션
//    @objc private func radioButtonTapped(_ sender: UIButton) {
//        let newIndex = sender.tag
//        
//        // 이전에 선택되어 있던 버튼을 해제
//        if let prevIndex = selectedIndex {
//            let rowView = stackView.arrangedSubviews[prevIndex]
//            // 해당 rowView 안에 있는 버튼 찾아서 isSelected = false
//            if let button = rowView.subviews.first(where: { $0 is UIButton }) as? UIButton {
//                button.isSelected = false
//            }
//        }
//        
//        // 새로 선택된 버튼
//        sender.isSelected = true
//        selectedIndex = newIndex
//    }
}
