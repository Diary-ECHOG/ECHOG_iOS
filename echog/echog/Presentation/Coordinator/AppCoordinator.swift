//
//  AppCoordinator.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import UIKit
import NetworkModule

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
    lazy var networkManager: NetworkManager = NetworkManager(baseURLResolver: baseURLManager)
    
    func start() {
        startOnBoardingCoordinator()
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
        let informationCoordinator = InformationCoordinator(navigationController: navigationController, networkManager: networkManager)
        children.removeAll()
        informationCoordinator.parentCoordinator = self
        children.append(informationCoordinator)
        informationCoordinator.start()
    }
    
    func startLoginCoordinator() {
        let logInCoordinator = LogInCoordinator(navigationController: navigationController, networkManager: networkManager)
        children.removeAll()
        logInCoordinator.parentCoordinator = self
        children.append(logInCoordinator)
        logInCoordinator.start()
    }
    
    func startHomeCoordinator() {
        
    }
}

