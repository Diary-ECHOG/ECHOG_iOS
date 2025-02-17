//
//  InformationViewController.swift
//  echog
//
//  Created by minsong kim on 12/8/24.
//

import Combine
import UIKit
import SnapKit

class InformationViewController: UIViewController, View, ToastProtocol, BottomSheetProtocol {
    var window: UIWindow? = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    
    var store: InformationStore
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정보를\n입력해 주세요."
        label.font = .semiboldHeadline24
        label.numberOfLines = 2
        return label
    }()
    
    private let emailTextField = TextFieldView(title: "이메일",placeHolder: "이메일", isNeedSecure: false)
    private let emailSendButton = SubButton(title: "코드발송")
    
    private let codeTextField = TextFieldView(title: "인증코드",placeHolder: "인증코드를 입력해 주세요.", isNeedSecure: false)
    private let codeCheckButton = SubButton(title: "인증하기", isEnabled: true)
    
    private let passwordTextField = TextFieldView(title: "비밀번호", placeHolder: "영문, 숫자 조합 8자", isNeedSecure: true)
    
    private let checkPasswordTextField = TextFieldView(title: "비밀번호 재입력", placeHolder: "비밀번호를 다시 입력해 주세요.", isNeedSecure: true)
    
    private let nextButton = MainButton(title: "다음", isEnabled: false)
    
    private let informationStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    private let emailStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.alignment = .trailing
        stack.distribution = .fill
        
        return stack
    }()
    
    private let codeStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.alignment = .trailing
        stack.distribution = .fill
        
        return stack
    }()
    
    private var activeTextField: UITextField?
    
    required init(reducer: InformationReducer) {
        self.store = InformationStore(reducer: reducer)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        emailTextField.mainTextField.delegate = self
        codeTextField.mainTextField.delegate = self
        passwordTextField.mainTextField.delegate = self
        checkPasswordTextField.mainTextField.delegate = self
        
        configureUI()
        setUpBind()
        bind()
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
    
    private func render(_ state: InformationReducer.State) {
        if state.isEmailFormPass == .success {
            self.emailSendButton.isEnabled = true
            self.emailTextField.removeErrorDescriptionLabel()
        } else if state.isEmailFormPass == .failure{
            self.emailTextField.showErrorDescriptionLabel("이메일 형식을 확인해주세요")
        }
        
        if state.isCodeSendSuccess == .success {
            self.emailTextField.makeMainTextFieldIsEnabledFalse()
            self.emailSendButton.changeSetting("전송완료", isEnabled: false)
        } else if state.isCodeSendSuccess == .failure {
            self.showToast(icon: .colorXmark, message: "다시 시도해주세요")
        }
        
        if state.isCodeCheckSuccess == .success {
            self.codeTextField.makeMainTextFieldIsEnabledFalse()
            self.codeCheckButton.changeSetting("인증완료", isEnabled: false)
        } else if state.isCodeCheckSuccess == .failure {
            self.showToast(icon: .colorXmark, message: "인증에 실패하였습니다")
        }
        
        if let _ = state.password {
            self.passwordTextField.removeErrorDescriptionLabel()
        } else {
            self.passwordTextField.showErrorDescriptionLabel("영문, 숫자 조합 8자")
        }
        
        if state.isPasswordCheckSuccess == .success {
            self.checkPasswordTextField.removeErrorDescriptionLabel()
        } else if state.isPasswordCheckSuccess == .failure {
            self.checkPasswordTextField.showErrorDescriptionLabel("비밀번호가 다릅니다")
        }
        
        if state.canShowTerms == .success {
            self.nextButton.isEnabled = true
        } else {
            self.nextButton.isEnabled = false
        }
        
        if let termsViewController = state.termsViewController {
            self.showHomeViewControllerInACustomizedSheet(viewController: termsViewController, height: 500)
        }
    }
    
    private func bind() {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: emailTextField.mainTextField)
            .compactMap {
                ($0.object as? UITextField)?.text
            }
            .sink { [weak self] email in
                self?.store.dispatch(.checkEmailForm(email))
            }
            .store(in: &cancellables)
        
        emailSendButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                let newEmail = self?.emailTextField.mainTextField.text
                
                self?.store.dispatch(.sendEmail(newEmail ?? ""))
            }
            .store(in: &cancellables)
        
        codeCheckButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                let email = self?.emailTextField.mainTextField.text ?? ""
                let code = self?.codeTextField.mainTextField.text ?? ""
                
                self?.store.dispatch(.checkCode(email: email, code: code))
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: passwordTextField.mainTextField)
            .compactMap {
                ($0.object as? UITextField)?.text
            }
            .sink { [weak self] password in
                guard let self = self else { return }
                
                self.store.dispatch(.checkPasswordForm(password))
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: checkPasswordTextField.mainTextField)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] confirmPassword in
                guard let self = self else { return }
                let password = self.passwordTextField.mainTextField.text ?? ""
                
                self.store.dispatch(.checkPassword(password: password, confirmPassword: confirmPassword))
                self.store.dispatch(.checkCanGoNext(isCodeCheckSuccess: store.state.isCodeCheckSuccess, isCheckPasswordSuccess: store.state.isPasswordCheckSuccess))
            }
            .store(in: &cancellables)
        
        nextButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                guard let self = self else { return }
                self.store.dispatch(.showTermPage(self.store))
            }
            .store(in: &cancellables)
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(informationStackView)
        view.addSubview(nextButton)
        emailStackView.addArrangedSubview(emailTextField)
        emailStackView.addArrangedSubview(emailSendButton)
        codeStackView.addArrangedSubview(codeTextField)
        codeStackView.addArrangedSubview(codeCheckButton)
        
        informationStackView.addArrangedSubview(emailStackView)
        informationStackView.addArrangedSubview(codeStackView)
        informationStackView.addArrangedSubview(passwordTextField)
        informationStackView.addArrangedSubview(checkPasswordTextField)
        
        emailSendButton.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(48)
            make.bottom.equalTo(emailTextField.snp.bottom)
        }
        
        codeCheckButton.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(48)
            make.bottom.equalTo(codeTextField.snp.bottom)
        }
        
        informationStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(informationStackView.snp.top).offset(-32)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let activeField = activeTextField else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        
        //nextButton
        nextButton.layer.cornerRadius = 0
        nextButton.snp.remakeConstraints { make in
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
        
        nextButton.layer.cornerRadius = 10
        nextButton.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
    }
}

extension InformationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField.mainTextField {
            codeTextField.mainTextField.becomeFirstResponder()
        } else if textField == codeTextField.mainTextField {
            passwordTextField.mainTextField.becomeFirstResponder()
        } else if textField == passwordTextField.mainTextField {
            checkPasswordTextField.mainTextField.becomeFirstResponder()
        } else if textField == checkPasswordTextField.mainTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == activeTextField {
            activeTextField = nil
        }
    }
}

//#Preview {
//    let vc = InformationViewController()
//
//    return vc
//}
