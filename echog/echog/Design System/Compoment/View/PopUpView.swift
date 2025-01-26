//
//  PopUpView.swift
//  echog
//
//  Created by minsong kim on 9/19/24.
//


import UIKit
import SnapKit

class PopUpView: UIView {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private let divideHLine: UIView = {
        let view = UIView()
        view.backgroundColor = .slate50
        
        return view
    }()
    
    private let divideVLine: UIView = {
        let view = UIView()
        view.backgroundColor = .slate50
        
        return view
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .mediumTitle15
        button.setTitleColor(.slate700, for: .normal)
 
        return button
    }()
 
    private let rightButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .mediumTitle15
        button.setTitleColor(.red500, for: .normal)
 
        return button
    }()
 
    convenience init(message: String, leftMessage: String?, rightMessage: String) {
        self.init()
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        
        messageLabel.setTextWithLineSpacing(message, font: .regularTitle15, lineSpacing: 8)
        leftButton.setTitle(leftMessage, for: .normal)
        rightButton.setTitle(rightMessage, for: .normal)
        
        configureLabel()
        configureLines()
        configureButtons()
    }
    
    private func configureLabel() {
        self.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(30)
        }
    }
    
    private func configureLines() {
        self.addSubview(divideHLine)
        self.addSubview(divideVLine)
        
        divideHLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(1)
        }
        
        divideVLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(50)
            make.centerX.bottom.equalToSuperview()
        }
    }
    
    private func configureButtons() {
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(divideVLine.snp.leading)
            make.centerY.equalTo(divideVLine.snp.centerY)
        }
        
        rightButton.snp.makeConstraints { make in
            make.leading.equalTo(divideVLine.snp.trailing)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(divideVLine.snp.centerY)
        }
    }
}
