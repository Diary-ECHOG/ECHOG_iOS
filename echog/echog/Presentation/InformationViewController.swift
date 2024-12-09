//
//  InformationViewController.swift
//  echog
//
//  Created by minsong kim on 12/8/24.
//

import UIKit
import SnapKit

class InformationViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정보를\n입력해 주세요."
        label.font = .semiboldHeadline24
        label.numberOfLines = 2
        return label
    }()
    
    let emailTextField = TextFieldView(title: "이메일",placeHolder: "이메일", isNeedSecure: false)
    
    let codeTextField = TextFieldView(title: "인증코드",placeHolder: "인증코드를 입력해 주세요.", isNeedSecure: false)
    let codeCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .grayscale20
        button.titleLabel?.font = .mediumTitle13
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    let passwordTextField = TextFieldView(title: "비밀번호", placeHolder: "영문, 숫자 조합 8자", isNeedSecure: true)
    
    let checkPasswordTextField = TextFieldView(title: "비밀번호 재입력", placeHolder: "비밀번호를 다시 입력해 주세요.", isNeedSecure: true)
    
    let nextButton = MainButton(title: "다음")
    
    let informationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    let codeStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.alignment = .trailing
        stack.distribution = .fill
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(informationStackView)
        view.addSubview(nextButton)
        codeStackView.addArrangedSubview(codeTextField)
        codeStackView.addArrangedSubview(codeCheckButton)
        
        informationStackView.addArrangedSubview(emailTextField)
        informationStackView.addArrangedSubview(codeStackView)
        informationStackView.addArrangedSubview(passwordTextField)
        informationStackView.addArrangedSubview(checkPasswordTextField)
        
        codeCheckButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.bottom.equalTo(codeTextField.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(180)
        }
        
        informationStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
    }
}

#Preview {
    let vc = InformationViewController()
    
    return vc
}
