//
//  SignOutConfirmViewController.swift
//  echog
//
//  Created by minsong kim on 2/25/25.
//

import Combine
import UIKit
import SnapKit

class SignOutConfirmViewController: UIViewController, ToastProtocol {
    var window: UIWindow? = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    
    var store: MyPageStore
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldLargetitle17
        label.textColor = .black
        label.text = "회원탈퇴"
        
        return label
    }()
    
    private let backButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "arrow.backward")
        configuration.baseForegroundColor = .slate800
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .slate100
        
        return view
    }()
    
    private let separatorSecondLine: UIView = {
        let view = UIView()
        view.backgroundColor = .slate100
        
        return view
    }()
    
    private let guideTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldTitle13
        label.text = "탈퇴 안내"
        label.textColor = .slate600
        
        return label
    }()
    
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.font = .regularTitle15
        label.textColor = .slate600
        label.numberOfLines = 2
        label.setTextWithLineSpacing("탈퇴 후에는 내 일기를 더 이상 보관하거나 볼 수 없어요. \n회원 탈퇴를 신청하려면 아래 문장을 입력해주세요.", font: .regularTitle15, lineSpacing: 12, alinment: .left, color: .slate600)
        
        return label
    }()
    
    private let textTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldTitle13
        label.text = "문구"
        label.textColor = .slate600
        
        return label
    }()
    
    private let confirmTextLabel: UILabel = {
        let label = UILabel()
        label.font = .regularTitle15
        label.textColor = .slate600
        label.numberOfLines = 2
        label.setTextWithLineSpacing("탈퇴를 신청하며 더 이상 내 일기를 작성하거나\n투표에 참여할 수 없음을 확인했습니다.", font: .mediumTitle15, lineSpacing: 12, alinment: .left, color: .countBlue)
        
        return label
    }()
    
    private let signOutTextView: UITextView = {
        let textView = UITextView()
        textView.font = .regularTitle15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.slate100.cgColor
        textView.layer.cornerRadius = 8
        textView.text = "탈퇴를 신청하며 더 이상 내 일기를 작성하거나 투표에 참여할 수 없음을 확인했습니다."
        textView.textColor = .textDisabled
        
        return textView
    }()
    
    private let signOutButton = MainButton(title: "탈퇴하기")
    
    required init(store: MyPageStore) {
        self.store = store
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureBar()
        configureGuideLabel()
        configureConfirmLabel()
        configureButton()
        
        bind()
        configureKeyboardGesture()
    }
    
    private func setUpBind() {
        store.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.render(newState)
            }
            .store(in: &cancellables)
    }
    
    private func render(_ state: MyPageReducer.State) {
        if state.isSignOutSuccess == .failure {
            showToast(icon: .colorXmark, message: "탈퇴에 실패했어요.")
        }
    }
    
    private func bind() {
        backButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.store.dispatch(.popPage)
            }
            .store(in: &cancellables)
        
        signOutButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.store.dispatch(.signOut)
            }
            .store(in: &cancellables)
    }
    
    private func configureBar() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).inset(8)
            make.centerY.equalTo(backButton.snp.centerY)
        }
    }
    
    private func configureGuideLabel() {
        view.addSubview(separatorLine)
        view.addSubview(guideTitleLabel)
        view.addSubview(guideLabel)
        
        separatorLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        guideTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(20)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(guideTitleLabel.snp.bottom).offset(16)
            make.leading.equalTo(guideTitleLabel)
        }
    }
    
    private func configureConfirmLabel() {
        view.addSubview(separatorSecondLine)
        view.addSubview(textTitleLabel)
        view.addSubview(confirmTextLabel)
        view.addSubview(signOutTextView)
        
        signOutTextView.delegate = self
        
        separatorSecondLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(guideLabel.snp.bottom).offset(16)
        }
        
        textTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorSecondLine.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(20)
        }
        
        confirmTextLabel.snp.makeConstraints { make in
            make.top.equalTo(textTitleLabel.snp.bottom).offset(16)
            make.leading.equalTo(guideTitleLabel)
        }
        
        signOutTextView.snp.makeConstraints { make in
            make.top.equalTo(confirmTextLabel.snp.bottom).offset(16)
            make.leading.equalTo(confirmTextLabel)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
    }
    
    private func configureButton() {
        view.addSubview(signOutButton)
        
        signOutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(50)
        }
    }
}

extension SignOutConfirmViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = .slate800
    }
    
    private func configureKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        // 다른 터치 이벤트 방해하지 않음
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//#Preview {
//    let vc = SignOutConfirmViewController(store: MyPageStore(reducer: MyPageReducer()))
//    
//    return vc
//}
