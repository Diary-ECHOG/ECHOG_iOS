//
//  LogInViewController.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import Combine
import UIKit
import SnapKit

final class LogInViewController: UIViewController, View, UITextFieldDelegate {
    var store: LogInStore
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.textColor = .slate800
        label.font = .semiboldHeadline24
        
        return label
    }()
    
    private let emailTextField = TextFieldView(title: "이메일",placeHolder: "이메일", isNeedSecure: false)
    
    private let passwordTextField = TextFieldView(title: "비밀번호", placeHolder: "영문, 숫자 조합 8자", isNeedSecure: true)
    
    private let findPasswordButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.regularTitle13
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("비밀번호를 찾고 싶어요!", attributes: titleContainer)
        configuration.titleAlignment = .leading
        configuration.baseForegroundColor = .slate800
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let signInButton: UIButton = {
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.regularTitle13
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("계정 가입하기", attributes: titleContainer)
        configuration.titleAlignment = .trailing
        configuration.baseForegroundColor = .slate800
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let logInButton = MainButton(title: "로그인")
    
    private var activeTextField: UITextField?
    
    required init(reducer: LogInReducer) {
        self.store = LogInStore(reducer: reducer)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.mainTextField.delegate = self
        passwordTextField.mainTextField.delegate = self
        
        configureBackgoundView()
        configureTitleAndTextFieldLayout()
        configureButtons()
        configureLogInButton()
        registerForKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func setUpBind() {
        store.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.render(newState)
            }
            .store(in: &cancellables)
    }
    
    private func render(_ state: LogInReducer.State) {
        if state.isLogInSuccess == .failure {
            //팝업 띄우기
        }
    }
    
    private func bind() {
        logInButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                guard let self else {
                    return
                }
                
                let email = emailTextField.mainTextField.text ?? ""
                let password = passwordTextField.mainTextField.text ?? ""
                
                store.dispatch(.goToLogIn(email: email, password: password))
            }
            .store(in: &cancellables)
    }
    
    //배경 화면 설정
    private func configureBackgoundView() {
        let backgoundView = UIImageView(image: UIImage(resource: .background2))
        
        view.addSubview(backgoundView)
        
        backgoundView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    //제목 및 textfield 레이아웃 설정
    private func configureTitleAndTextFieldLayout() {
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.centerY).inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(emailTextField)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-28)
            make.leading.equalTo(emailTextField)
        }
    }
    
    //버튼 레이아웃 설정
    private func configureButtons() {
        view.addSubview(findPasswordButton)
        view.addSubview(signInButton)
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
        }
        
        signInButton.snp.makeConstraints { make in
            make.centerY.equalTo(findPasswordButton)
            make.trailing.equalTo(passwordTextField)
        }
    }
    
    //로그인 버튼 레이아웃 설정
    private func configureLogInButton() {
        view.addSubview(logInButton)
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(findPasswordButton.snp.bottom).offset(16)
            make.leading.trailing.equalTo(passwordTextField)
            make.height.equalTo(48)
        }
    }
}

extension LogInViewController {
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue, let activeField = activeTextField else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        
        //logInButton
        logInButton.layer.cornerRadius = 0
        logInButton.snp.remakeConstraints { make in
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top)
            make.height.equalTo(50)
            make.width.equalTo(self.view.frame.width)
        }
        
        // activeField의 frame을 현재 뷰의 좌표계로 변환
        let fieldFrameInView = activeField.convert(activeField.bounds, to: self.view)
        let keyboardTopY = self.view.frame.height - keyboardFrame.height
        
        // activeField의 하단이 키보드 상단보다 아래에 있으면 뷰를 올림
        if fieldFrameInView.maxY > keyboardTopY - 50 {
            let shiftDistance = fieldFrameInView.maxY - keyboardTopY + 70
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -shiftDistance
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
        
        logInButton.layer.cornerRadius = 10
        logInButton.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
    }
}

//#Preview {
//    let vc = LogInViewController()
//    
//    return vc
//}
