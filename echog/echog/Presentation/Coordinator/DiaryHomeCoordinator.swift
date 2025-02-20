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
    private var reducer = DiaryReducer()
    private lazy var store = DiaryStore(reducer: reducer)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        reducer.delegate = self
    }
    
    func start() {
        pushDiaryHomeViewController()
    }
}

extension DiaryCoordinator: DiaryNavigation {
    func pushDiaryHomeViewController() {
        let diaryHomeViewController = DiaryHomeViewController(store: store)
        navigationController.pushViewController(diaryHomeViewController, animated: false)
    }
    
    func pushDiaryEditorViewController() {
        let diaryEditorViewController = DiaryEditorViewController(store: store)
        navigationController.pushViewController(diaryEditorViewController, animated: false)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: false)
    }
    
    func pushDiaryViewerViewController() {
        let diaryViewerViewController = DiaryViewerViewController(store: store)
        navigationController.pushViewController(diaryViewerViewController, animated: false)
    }
    
    func goToVoteCoordinator() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startVoteCoordinator()
        appCoordinator?.childDidFinish(self)
    }
    
    func goToMyPageCoordinator() {
        let appCoordinator = parentCoordinator as? AppCoordinator
        appCoordinator?.startMyPageCoordinator()
        appCoordinator?.childDidFinish(self)
    }
}
