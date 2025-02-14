//
//  PasswordFinderViewController.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import UIKit
import SnapKit

final class PasswordFinderViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 찾기"
        label.textColor = .slate800
        label.font = .semiboldHeadline24
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text =
        """
        비밀번호를 찾을 이메일을 입력해주세요.
        해당 이메일로 비밀번호 재설정 메일이 발송됩니다.
        """
        label.textColor = .slate700
        label.font = .regularTitle15
        
        return label
    }()
    
    private let emailTextField = TextFieldView(title: "이메일",placeHolder: "이메일", isNeedSecure: false)
    
    private let resetButton = MainButton(title: "재설정하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
        configureLabels()
    }
    
    private func configureButton() {
        view.addSubview(resetButton)
        
        resetButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func configureLabels() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalTo(resetButton.snp.top).offset(-16)
            make.leading.trailing.equalTo(resetButton)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-40)
            make.leading.trailing.equalTo(emailTextField)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-16)
            make.leading.trailing.equalTo(descriptionLabel)
        }
    }
}

#Preview {
    let vc = PasswordFinderViewController()
    
    return vc
}
