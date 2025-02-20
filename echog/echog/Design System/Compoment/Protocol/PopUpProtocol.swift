//
//  PopUpProtocol.swift
//  echog
//
//  Created by minsong kim on 9/20/24.
//

import UIKit


protocol PopUpProtocol where Self: UIViewController {
    var window: UIWindow? { get set }
}

extension PopUpProtocol {
    func showPopUp(view: PopUpView) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        window = UIWindow(windowScene: windowScene)
        window?.windowLevel = .alert
        window?.backgroundColor = .black.withAlphaComponent(0.48)
        
        window?.addSubview(view)
        view.sizeToFit()
        
        view.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(300)
        }
        
        window?.isHidden = false
    }
    
    func dismissPopUp(view: PopUpView) {
        view.removeFromSuperview()
        window?.isHidden = true
        window = nil
    }
}
