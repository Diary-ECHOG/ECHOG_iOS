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
    private var reducer = LogInReducer()
    private lazy var store = LogInStore(reducer: reducer)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        reducer.delegate = self
    }
    
    func start() {
        pushLogInViewController()
    }
}

extension LogInCoordinator: LogInNavigation {
    func pushLogInViewController() {
        let logInViewController = LogInViewController(store: store)
        
        navigationController.pushViewController(logInViewController, animated: true)
    }
    
    func pushLogInCompleteViewController() {
        let logInCompleteViewController = LogInCompleteViewController(store: store)
        
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
        appCoordinator?.startDiaryCoordinator()
        appCoordinator?.childDidFinish(self)
    }
}
