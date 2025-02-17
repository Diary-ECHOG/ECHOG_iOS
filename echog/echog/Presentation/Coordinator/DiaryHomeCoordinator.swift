//
//  DiaryHomeCoordinator.swift
//  echog
//
//  Created by minsong kim on 1/24/25.
//

import UIKit

protocol DiaryNavigation: AnyObject {
    func pushDiaryHomeViewController()
}

class DiaryCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        pushDiaryHomeViewController()
    }
}

extension DiaryCoordinator: DiaryNavigation {
    func pushDiaryHomeViewController() {
//        let informationLoadingViewController = InformationLoadingViewController(coordinator: self)
//        navigationController.pushViewController(informationLoadingViewController, animated: true)
    }
}
