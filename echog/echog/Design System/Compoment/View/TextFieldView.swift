//
//  TextFieldView.swift
//  echog
//
//  Created by minsong kim on 12/8/24.
//

import Combine
import UIKit
import SnapKit

class TextFieldView: UIStackView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumTitle15
        label.textAlignment = .left
        
        return label
    }()
    let mainTextField: UITextField = {
        let text = UITextField()
        text.font = .mediumTitle15
        text.layer.cornerRadius = 10
        text.layer.borderColor = UIColor.border.cgColor
        text.layer.borderWidth = 1
        text.textColor = .textSub
        text.addLeftPadding()
        
        return text
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red500
        label.font = .regularTitle13
        
        return label
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    convenience init(title: String, placeHolder: String, isNeedSecure: Bool) {
        self.init(frame: .zero)
        self.axis = .vertical
        self.spacing = 8
        self.mainTextField.placeholder = placeHolder
        self.mainTextField.smartDashesType = .no
        self.titleLabel.text = title
        
        if isNeedSecure {
            let secureModeButton = UIButton()
            secureModeButton.setImage(UIImage(resource: .passwordInvisible), for: .normal)
            
            mainTextField.addSecureMode(secureModeButton)
            mainTextField.isSecureTextEntry = true
            
            secureModeButton.publisher(for: .touchUpInside)
                .sink { [weak self] _ in
                    self?.mainTextField.toggleSecureModeButton(secureModeButton)
                }
                .store(in: &cancellables)
            
        }
        
        configureUI()
    }
    
    private func configureUI() {
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(mainTextField)
        self.addSubview(descriptionLabel)
        
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        mainTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTextField.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func showErrorDescriptionLabel(_ text: String) {
        descriptionLabel.text = text
        mainTextField.layer.borderColor = UIColor.red500.cgColor
    }
    
    func removeErrorDescriptionLabel() {
        descriptionLabel.text = ""
        mainTextField.layer.borderColor = UIColor.border.cgColor
    }
    
    func makeMainTextFieldIsEnabledFalse() {
        mainTextField.isEnabled = false
        mainTextField.backgroundColor = .slate25
        mainTextField.layer.borderColor = UIColor.slate100.cgColor
        mainTextField.textColor = .slate100
    }
}
