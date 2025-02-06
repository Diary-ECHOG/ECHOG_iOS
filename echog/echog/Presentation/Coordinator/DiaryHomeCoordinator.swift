//
//  DiaryHomeCoordinator.swift
//  echog
//
//  Created by minsong kim on 1/24/25.
//

//import UIKit
//
//protocol DiaryHomeNavigation: AnyObject {
//    func pushInformationLoadingViewController()
//    func pushInformationViewController()
//}
//
//class DiaryHomeCoordinator: Coordinator {
//    var parentCoordinator: Coordinator?
//    var children: [Coordinator] = []
//    var navigationController: UINavigationController
//    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func start() {
//        pushInformationLoadingViewController()
//    }
//}
//
//extension DiaryHomeCoordinator: DiaryHomeNavigation {
//    func pushInformationLoadingViewController() {
////        let informationLoadingViewController = InformationLoadingViewController(coordinator: self)
////        navigationController.pushViewController(informationLoadingViewController, animated: true)
//    }
//    
//    func pushInformationViewController() {
//        let informationViewController = InformationViewController()
//        navigationController.pushViewController(informationViewController, animated: true)
//    }
//    
//    func popInformationViewController() {
//        navigationController.popViewController(animated: false)
//        children.removeLast()
//    }
//}
