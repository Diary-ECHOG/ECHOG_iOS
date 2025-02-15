//
//  LogInCoordinator.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import UIKit
import NetworkModule

protocol LogInNavigation: AnyObject {
    func pushLogInViewController()
}

class LogInCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var networkManager: NetworkManager
    
    init(navigationController: UINavigationController, networkManager: NetworkManager) {
        self.navigationController = navigationController
        self.networkManager = networkManager
    }
    
    func start() {
        pushLogInViewController()
    }
}

extension LogInCoordinator: LogInNavigation {
    func pushLogInViewController() {
        let logInViewController = LogInViewController(reducer: LogInReducer(networkManager: networkManager))
        
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
