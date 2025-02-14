//
//  PasswordCompleteViewController.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import UIKit
import SnapKit
import Lottie

final class PasswordCompleteViewController: UIViewController {
    private let checkAnimationView: LottieAnimationView = {
        let view = LottieAnimationView(name: "join_check")
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.setTextWithLineSpacing(
            """
            가입 시 입력한 이메일로
            비밀번호 재설정
            메일이 발송되었어요.
            """,
            font: .semiboldSubheadline22,
            lineSpacing: 8
        )
        
        return label
    }()
    
    private let logInButton = MainButton(title: "로그인")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureUI()
        checkAnimationView.play()
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(checkAnimationView)
        view.addSubview(logInButton)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        checkAnimationView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(52)
        }
        
        logInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
    }
}

#Preview {
    let vc = PasswordCompleteViewController()
    
    return vc
}
