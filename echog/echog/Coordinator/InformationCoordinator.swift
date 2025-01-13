//
//  SignInCoordinator.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import UIKit

protocol InformationNavigation: AnyObject {
    func pushInformationLoadingViewController()
    func pushInformationViewController()
}

class InformationCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        pushInformationLoadingViewController()
    }
}

extension InformationCoordinator: InformationNavigation {
    func pushInformationLoadingViewController() {
        let informationLoadingViewController = InformationLoadingViewController(coordinator: self)
        navigationController.pushViewController(informationLoadingViewController, animated: true)
    }
    
    func pushInformationViewController() {
        let informationViewController = InformationViewController()
        navigationController.pushViewController(informationViewController, animated: true)
    }
    
    func popInformationViewController() {
        navigationController.popViewController(animated: false)
        children.removeLast()
    }
}
