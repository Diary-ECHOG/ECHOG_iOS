//
//  AppCoordinator.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
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
        let informationCoordinator = InformationCoordinator(navigationController: navigationController)
        children.removeAll()
        informationCoordinator.parentCoordinator = self
        children.append(informationCoordinator)
        informationCoordinator.start()
    }
    
    func startLoginCoordinator() {
        
    }
    
    func startHomeCoordinator() {
        
    }
}

