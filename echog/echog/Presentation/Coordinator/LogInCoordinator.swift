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
        var reducer = LogInReducer()
        reducer.delegate = self
        
        let logInViewController = LogInViewController(reducer: reducer)
        
        navigationController.pushViewController(logInViewController, animated: true)
    }
    
    func pushLogInCompleteViewController() {
        var reducer = LogInReducer()
        reducer.delegate = self
        
        let logInCompleteViewController = LogInCompleteViewController(reducer: reducer)
        
        navigationController.pushViewController(logInCompleteViewController, animated: true)
    }
    
    func goToPasswordViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startPasswordCoordinator()
        appCoordinator?.childDidFinish(self)
    }
    
    func goToSignInViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startInformationCoordinator()
        appCoordinator?.childDidFinish(self)
    }
    
    func goToDiaryHomeViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startHomeCoordinator()
        appCoordinator?.childDidFinish(self)
    }
}
