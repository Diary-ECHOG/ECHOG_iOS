//
//  PopUpView.swift
//  echog
//
//  Created by minsong kim on 9/19/24.
//

/*
import UIKit
import SnapKit

class PopUpView: UIView {
    private let iconImageView: UIImageView = {
        let view = UIImageView(image: .echo)
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayscale0
        label.textAlignment = .center
        label.font = .mediumBody1
        
        return label
    }()
    
    private let grayButton = MainButton(color: .gray, title: "")
    private let echogButton = MainButton(color: .light, title: "")
    
    convenience init(icon image: UIImage?, message: String, grayMessage: String?, echogMessage: String) {
        self.init()
        self.backgroundColor = .grayscale100
        self.layer.cornerRadius = 10
        
        if let grayMessage {
            self.grayButton.setTitle(grayMessage, for: .normal)
            self.echogButton.setTitle(echogMessage, for: .normal)
            configureButtons()
        } else {
            self.echogButton.setTitle(echogMessage, for: .normal)
            configureEchogButton()
        }
        
        if let image {
            self.iconImageView.image = image.resize(newWidth: 80)
            self.messageLabel.text = message
            configureIconView()
        } else {
            self.messageLabel.text = message
            configureLabel()
        }
    }
    
    private func configureIconView() {
        self.addSubview(iconImageView)
        self.addSubview(messageLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(80)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.bottom.equalTo(echogButton.snp.top).offset(-44)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(iconImageView.snp.bottom).offset(24)
        }
    }
    
    private func configureLabel() {
        self.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.bottom.equalTo(echogButton.snp.top).offset(-44)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(40)
        }
    }
    
    private func configureEchogButton() {
        self.addSubview(echogButton)
        
        echogButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }
    
    private func configureButtons() {
        self.addSubview(grayButton)
        self.addSubview(echogButton)
        
        grayButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(50)
        }
        
        echogButton.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }
}
*/
