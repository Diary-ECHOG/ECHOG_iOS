//
//  MyPageCoordinator.swift
//  echog
//
//  Created by minsong kim on 2/20/25.
//

import UIKit

protocol MyPageNavigation: AnyObject {
    func goToDiaryViewController()
}

class MyPageCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    private var reducer = MyPageReducer()
    private lazy var store = MyPageStore(reducer: reducer)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        reducer.delegate = self
    }
    
    func start() {
        pushMyPageViewController()
    }
}

extension MyPageCoordinator: MyPageNavigation {
    func pushMyPageViewController() {
        let myPageViewController = MyPageViewController(store: store)
        navigationController.pushViewController(myPageViewController, animated: false)
    }
    
    func pushSignOutReasonViewController() {
        let signOutResonViewController = SignOutReasonViewController(store: store)
        navigationController.pushViewController(signOutResonViewController, animated: true)
    }
    
    func pushSignOutConfirmViewController() {
        let signOutConfirmViewController = SignOutConfirmViewController(store: store)
        navigationController.pushViewController(signOutConfirmViewController, animated: true)
    }
    
    func pushTermsViewController() {
        let termsViewController = TermsCheckViewController(store: store)
        navigationController.pushViewController(termsViewController, animated: false)
    }
    
    func goToDiaryViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startDiaryCoordinator()
        appCoordinator?.childDidFinish(self)
    }
    
    func goToLogInViewController() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startLoginCoordinator()
        appCoordinator?.childDidFinish(self)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
