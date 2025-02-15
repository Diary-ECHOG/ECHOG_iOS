//
//  SignInCoordinator.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import UIKit
import Network

protocol InformationNavigation: AnyObject {
    func pushInformationLoadingViewController()
    func pushInformationViewController()
}

class InformationCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var networkManager: NetworkManager
    
    init(navigationController: UINavigationController, networkManager: NetworkManager) {
        self.navigationController = navigationController
        self.networkManager = networkManager
    }
    
    func start() {
        pushInformationLoadingViewController()
    }
}

extension InformationCoordinator: InformationNavigation {
    func pushInformationLoadingViewController() {
        var reducer = InformationReducer(networkManager: networkManager)
        reducer.delegate = self
        
        let informationLoadingViewController = InformationLoadingViewController(reducer: reducer)
        navigationController.pushViewController(informationLoadingViewController, animated: true)
    }
    
    func pushInformationViewController() {
        var reducer = InformationReducer(networkManager: networkManager)
        reducer.delegate = self
        
        let informationViewController = InformationViewController(reducer: reducer)
        navigationController.pushViewController(informationViewController, animated: true)
    }
    
    func pushWelcomeViewController() {
        var reducer = InformationReducer(networkManager: networkManager)
        reducer.delegate = self
        
        let welcomeViewController = WelcomeViewController()
        navigationController.pushViewController(welcomeViewController, animated: true)
    }
    
    func goToLogInViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startLoginCoordinator()
        appCoordinator?.childDidFinish(self)
    }
}
