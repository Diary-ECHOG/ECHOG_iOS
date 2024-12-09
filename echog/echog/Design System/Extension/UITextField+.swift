//
//  UITextField+.swift
//  echog
//
//  Created by minsong kim on 12/9/24.
//

import UIKit
import SnapKit

extension UITextField {
    func addSecureMode(_ button: UIButton) {
        let containerView = UIView()
        containerView.addSubview(button)
        
        button.snp.makeConstraints({ make in
            make.height.width.equalTo(16)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
        })
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(16)
        }
        
        self.rightView = containerView
        self.rightViewMode = .always
    }
    
    func toggleSecureModeButton(_ button: UIButton) {
        isSecureTextEntry.toggle()
        
        if isSecureTextEntry {
            button.setImage(UIImage(resource: .passwordInvisible), for: .normal)
        } else {
            button.setImage(UIImage(resource: .passwordVisible), for: .normal)
        }
    }
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
