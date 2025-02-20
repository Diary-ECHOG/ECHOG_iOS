//
//  AppCoordinator.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import UIKit
import NetworkKit
import NetworkFeatureKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var baseURLManager: BaseURLManager = {
        let base = BaseURLManager()
        guard let url = URL(string: "http://api.echog.me") else {
            return base
        }
        
        base.register(url, for: .api)
        
        return base
    }()
    
    func start() {
        startOnBoardingCoordinator()
        
        UserNetwork.shared.configureNetworkManager(baseURLManager)
        DiaryNetwork.shared.configureNetworkManager(baseURLManager)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startOnBoardingCoordinator() {
        let onBoardingCoordinator = OnBoardingCoordinator(navigationController: navigationController)
        children.removeAll()
        onBoardingCoordinator.parentCoordinator = self
        children.append(onBoardingCoordinator)
        onBoardingCoordinator.start()
    }
    
    func startInformationCoordinator() {
        let informationCoordinator = InformationCoordinator(navigationController: navigationController)
        children.removeAll()
        informationCoordinator.parentCoordinator = self
        children.append(informationCoordinator)
        informationCoordinator.start()
    }
    
    func startLoginCoordinator() {
        let logInCoordinator = LogInCoordinator(navigationController: navigationController)
        children.removeAll()
        logInCoordinator.parentCoordinator = self
        children.append(logInCoordinator)
        logInCoordinator.start()
    }
    
    func startPasswordCoordinator() {
        let passwordCoordinator = PasswordCoordinator(navigationController: navigationController)
        children.removeAll()
        passwordCoordinator.parentCoordinator = self
        children.append(passwordCoordinator)
        passwordCoordinator.start()
    }
    
    func startDiaryCoordinator() {
        let diaryCoordinator = DiaryCoordinator(navigationController: navigationController)
        children.removeAll()
        diaryCoordinator.parentCoordinator = self
        children.append(diaryCoordinator)
        diaryCoordinator.start()
    }
    
    func startVoteCoordinator() {
        
    }
    
    func startMyPageCoordinator() {
        
    }
}
