//
//  WelcomeViewController.swift
//  echog
//
//  Created by minsong kim on 2/12/25.
//

import Combine
import UIKit
import Lottie

final class WelcomeViewController: UIViewController {
    var store: InformationStore
    private var cancellables = Set<AnyCancellable>()
    
    private let animationView = LottieAnimationView(name: "particle")
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "가입을\n축하합니다!"
        label.textAlignment = .center
        label.font = .semiboldSubheadline22
        label.numberOfLines = 2
        
        return label
    }()
    
    required init(reducer: InformationReducer) {
        self.store = InformationStore(reducer: reducer)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(animationView)
        configureTitleLabel()
        
        animationView.frame = self.view.bounds
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        
        animationView.play()
        
        setUpTapGesture()
    }
    
    private func setUpTapGesture() {
        view.throttleTapGesturePublisher()
            .sink { [weak self] view in
                guard let self else {
                    return
                }
                
                self.store.dispatch(.goToLogIn)
            }
            .store(in: &cancellables)
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
