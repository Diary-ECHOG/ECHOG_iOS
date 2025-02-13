//
//  WelcomeViewController.swift
//  echog
//
//  Created by minsong kim on 2/12/25.
//

import UIKit
import Lottie

final class WelcomeViewController: UIViewController {
    private let animationView = LottieAnimationView(name: "particle")
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "가입을\n축하합니다!"
        label.textAlignment = .center
        label.font = .semiboldSubheadline22
        label.numberOfLines = 2
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(animationView)
        configureTitleLabel()
        
        animationView.frame = self.view.bounds
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        
        animationView.play()
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
