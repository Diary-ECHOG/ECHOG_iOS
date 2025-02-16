//
//  LogInCoordinator.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import UIKit

protocol LogInNavigation: AnyObject {
    func pushLogInViewController()
}

class LogInCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        pushLogInViewController()
    }
}

extension LogInCoordinator: LogInNavigation {
    func pushLogInViewController() {
        let logInViewController = LogInViewController(reducer: LogInReducer())
        
        navigationController.pushViewController(logInViewController, animated: true)
    }
    
    func pushLogInCompleteViewController() {
        let logInCompleteViewController = LogInCompleteViewController()
        
        navigationController.pushViewController(logInCompleteViewController, animated: true)
    }
    
    func pushPasswordFinderViewController() {
        let passwordFinderViewController = PasswordFinderViewController()
        
        navigationController.pushViewController(passwordFinderViewController, animated: true)
    }
    
    func pushPasswordCompleteViewController() {
        let passwordCompleteViewController = PasswordCompleteViewController()
        
        navigationController.pushViewController(passwordCompleteViewController, animated: true)
    }
    
    func goToSignInViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startInformationCoordinator()
        appCoordinator?.childDidFinish(self)
    }
}
