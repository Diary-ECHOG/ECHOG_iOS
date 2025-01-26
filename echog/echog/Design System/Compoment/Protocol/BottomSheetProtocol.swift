//
//  BottomSheetProtocol.swift
//  echog
//
//  Created by minsong kim on 1/26/25.
//

import UIKit

protocol BottomSheetProtocol where Self: UIViewController { }

extension BottomSheetProtocol {
    func showHomeViewControllerInACustomizedSheet(viewController: UIViewController, height: CGFloat) {
        let detentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let safeAreaBottom = windowScene?.windows.first?.safeAreaInsets.bottom ?? 0

            return height - safeAreaBottom
        }
        
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [customDetent]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.preferredCornerRadius = 25
        }
        
        present(viewController, animated: true, completion: nil)
    }
}
