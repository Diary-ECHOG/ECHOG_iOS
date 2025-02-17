//
//  PasswordCoordinator.swift
//  echog
//
//  Created by minsong kim on 2/17/25.
//

import UIKit

protocol PasswordNavigation: AnyObject {
    func pushPasswordFinderViewController()
    func pushPasswordCompleteViewController()
}

class PasswordCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        pushPasswordFinderViewController()
    }
}

extension PasswordCoordinator: PasswordNavigation {
    func pushPasswordFinderViewController() {
        let passwordFinderViewController = PasswordFinderViewController()
        
        navigationController.pushViewController(passwordFinderViewController, animated: true)
    }
    
    func pushPasswordCompleteViewController() {
        var reducer = LogInReducer()
        reducer.delegate = self
        
        let passwordCompleteViewController = PasswordCompleteViewController(reducer: reducer)
        
        navigationController.pushViewController(passwordCompleteViewController, animated: true)
    }
    
    func goToLogInViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startLoginCoordinator()
        appCoordinator?.childDidFinish(self)
    }
}
