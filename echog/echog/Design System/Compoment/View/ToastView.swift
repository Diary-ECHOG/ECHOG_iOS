//
//  ToastLabel.swift
//  echog
//
//  Created by minsong kim on 9/19/24.
//

import UIKit
import SnapKit

class ToastView: UIView {
    let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumTitle15
        label.textColor = .white
        
        return label
    }()
    
    convenience init(icon image: UIImage, text: String) {
        self.init()
        self.backgroundColor = .black.withAlphaComponent(0.8)
        self.layer.cornerRadius = 10
        self.messageLabel.text = text
        self.iconImageView.image = image.resize(newWidth: 20)
        
        configureUI()
    }
    
    private func configureUI() {
        configureIconView()
        configureLabel()
    }
    
    private func configureIconView() {
        self.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureLabel() {
        self.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
}
