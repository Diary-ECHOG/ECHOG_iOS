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
    private var reducer = InformationReducer()
    private lazy var store = InformationStore(reducer: reducer)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        reducer.delegate = self
    }
    
    func start() {
        pushInformationLoadingViewController()
    }
}

extension InformationCoordinator: InformationNavigation {
    func pushInformationLoadingViewController() {
        let informationLoadingViewController = InformationLoadingViewController(store: store)
        navigationController.pushViewController(informationLoadingViewController, animated: true)
    }
    
    func pushInformationViewController() {
        let informationViewController = InformationViewController(store: store)
        navigationController.pushViewController(informationViewController, animated: true)
    }
    
    func pushWelcomeViewController() {
        let welcomeViewController = WelcomeViewController(store: store)
        navigationController.pushViewController(welcomeViewController, animated: true)
    }
    
    func goToLogInViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startLoginCoordinator()
        appCoordinator?.childDidFinish(self)
    }
}
