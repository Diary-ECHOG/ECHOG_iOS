//
//  PopUpProtocol.swift
//  echog
//
//  Created by minsong kim on 9/20/24.
//

import UIKit

/*
protocol PopUpProtocol where Self: UIViewController {
    var window: UIWindow? { get set }
//    var popUpView: PopUpView { get set }
}

extension PopUpProtocol {
    func showPopUp(popUpView: PopUpView) {
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        window = UIWindow(windowScene: windowScene)
        window?.windowLevel = .alert
        window?.backgroundColor = .black.withAlphaComponent(0.48)
        
        window?.addSubview(popUpView)
        popUpView.sizeToFit()
        let popUpHeight = popUpView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
                
        
        popUpView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(popUpHeight)
        }
        
        window?.isHidden = false
    }
    
    func dismissPopUp() {
//        popUpView.removeFromSuperview()
        window?.isHidden = true
        window = nil
    }
}
*/
