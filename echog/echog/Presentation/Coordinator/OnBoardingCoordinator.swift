//
//  OnBoardingCoordinator.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import UIKit

protocol OnBoardingNavigation: AnyObject {
    func goToLogInViewController()
}

class OnBoardingCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    private var reducer = OnBoardingReducer()
    private lazy var store = OnBoardingStore(reducer: reducer)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        reducer.delegate = self
    }
    
    func start() {
        goToOnBoardingViewController()
    }
}

extension OnBoardingCoordinator: OnBoardingNavigation {
    func goToOnBoardingViewController() {
        let onBoardingViewController = OnBoardingViewController(store: store)
        navigationController.pushViewController(onBoardingViewController, animated: false)
    }
    
    func goToLogInViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startLoginCoordinator()
        appCoordinator?.childDidFinish(self)
    }
}
