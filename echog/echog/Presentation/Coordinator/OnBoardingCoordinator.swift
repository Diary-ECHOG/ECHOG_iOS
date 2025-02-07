//
//  OnBoardingCoordinator.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import UIKit

protocol OnBoardingNavigation: AnyObject {
    func goToInformationViewController()
}

class OnBoardingCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToOnBoardingViewController()
    }
}

extension OnBoardingCoordinator: OnBoardingNavigation {
    func goToOnBoardingViewController() {
        var reducer = OnBoardingReducer()
        reducer.delegate = self
        
        let onBoardingViewController = OnBoardingViewController(reducer: reducer)
        navigationController.pushViewController(onBoardingViewController, animated: false)
    }
    
    func goToInformationViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startInformationCoordinator()
        appCoordinator?.childDidFinish(self)
    }
}
