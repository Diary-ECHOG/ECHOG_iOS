//
//  ToastProtocol.swift
//  echog
//
//  Created by minsong kim on 9/19/24.
//

import UIKit
import SnapKit

protocol ToastProtocol where Self: UIViewController {
    var window: UIWindow? { get set }
}

extension ToastProtocol {
    func showToast(icon: UIImage, message: String) {
        let toastLabel = ToastView(icon: icon, text: message)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        window = UIWindow(windowScene: windowScene)
        window?.windowLevel = .alert
        window?.isUserInteractionEnabled = false
        window?.addSubview(toastLabel)
        
        toastLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().inset(100)
        }
        
        self.window?.isHidden = false
        UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseOut, animations: {
            self.window?.alpha = 0.0
        }) { _ in
            self.window?.alpha = 1.0
            self.window?.isHidden = true
        }
    }
}
