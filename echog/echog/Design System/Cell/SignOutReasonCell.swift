//
//  SignOutReasonCell.swift
//  echog
//
//  Created by minsong kim on 2/25/25.
//

import UIKit
import SnapKit

class SignOutReasonCell: UITableViewCell {
    static let identifier = "SignOutReasonCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .regularTitle15
        label.textColor = .slate800
        
        return label
    }()
    
    private let checkButton = SelectionButton(isSelected: false)
    
    let reasonTextView: UITextView = {
        let textView = UITextView()
        textView.font = .regularTitle15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.slate100.cgColor
        textView.layer.cornerRadius = 8
        textView.backgroundColor = .slate25
        textView.text = "탈퇴사유를 입력해 주세요."
        textView.textColor = .textDisabled
        
        return textView
    }()
    
    private func configureLabels() {
        self.addSubview(titleLabel)
        self.addSubview(checkButton)
        
        checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(20)
            make.width.height.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(8)
            make.centerY.equalTo(checkButton)
            make.height.equalTo(22)
        }
    }
    
    private func configureTextView() {
        self.addSubview(reasonTextView)
        
        reasonTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
    }
    
    func configureCells(title: String, isTextView: Bool = false) {
        titleLabel.text = title
        
        configureLabels()
        
        if isTextView {
            configureTextView()
        }
    }
}
