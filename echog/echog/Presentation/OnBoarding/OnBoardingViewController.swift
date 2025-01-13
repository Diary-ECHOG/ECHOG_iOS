//
//  OnBoardingViewController.swift
//  echog
//
//  Created by minsong kim on 1/11/25.
//

import Combine
import UIKit
import SnapKit

class OnBoardingViewController: UIViewController {
    private var page: Int = 0
    private var state = CurrentValueSubject<OnBoardingState, Never>(.logo)
    private let intent = PassthroughSubject<OnBoardingIntent, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    weak var coordinator: OnBoardingNavigation!
    
    init(coordinator: OnBoardingNavigation) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleImageView: UIImageView = {
        let view = UIImageView(image: UIImage.logo)
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldSubheadline22
        label.textAlignment = .center
        
        return label
    }()
    
    private let startButton = MainButton(title: "시작하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureBackgoundView()
        configureView()
        setUpTapGesture()
        setUpBindings()
    }
    
    private func setUpBindings() {
        intent.sink { [weak self] intent in
            guard let self else {
                return
            }
            
            self.state.send(intent.reducer())
        }
        .store(in: &cancellables)
        
        state.sink { [weak self] state in
            if state == .start {
                //화면 전환
                self?.coordinator.goToInformationViewController()
            } else {
                self?.updateUI(image: state.detail?.image, title: state.detail?.title, isStartButton: state.detail?.isStartButton)
            }
        }
        .store(in: &cancellables)
    }
    
    private func updateUI(image: UIImage?, title: String?, isStartButton: Bool?) {
        titleImageView.image = image
        titleLabel.text = title
        
        if let isStartButton, isStartButton == true {
            view.addSubview(startButton)
            
            startButton.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(50)
                make.height.equalTo(50)
            }
        }
    }
    
    private func setUpTapGesture() {
        view.throttleTapGesturePublisher()
            .sink { [weak self] view in
                guard let self else {
                    return
                }
                
                self.page += 1
                self.intent.send(.goToNext(page: page))
            }
            .store(in: &cancellables)
        
        startButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.intent.send(.goToStart)
            }
            .store(in: &cancellables)
    }
    
    private func configureBackgoundView() {
        let backgoundView = UIImageView(image: UIImage(resource: .backgound))
        
        view.addSubview(backgoundView)
        
        backgoundView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func configureView() {
        view.addSubview(titleImageView)
        view.addSubview(titleLabel)
        
        titleImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(34)
        }
    }
}

//#Preview {
//    let vc = OnBoardingViewController()
//    
//    return vc
//}
