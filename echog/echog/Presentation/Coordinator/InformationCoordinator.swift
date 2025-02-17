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
        var reducer = InformationReducer()
        reducer.delegate = self
        
        let informationLoadingViewController = InformationLoadingViewController(reducer: reducer)
        navigationController.pushViewController(informationLoadingViewController, animated: true)
    }
    
    func pushInformationViewController() {
        var reducer = InformationReducer()
        reducer.delegate = self
        
        let informationViewController = InformationViewController(reducer: reducer)
        navigationController.pushViewController(informationViewController, animated: true)
    }
    
    func pushWelcomeViewController() {
        var reducer = InformationReducer()
        reducer.delegate = self
        
        let welcomeViewController = WelcomeViewController(reducer: reducer)
        navigationController.pushViewController(welcomeViewController, animated: true)
    }
    
    func goToLogInViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startLoginCoordinator()
        appCoordinator?.childDidFinish(self)
    }
}
