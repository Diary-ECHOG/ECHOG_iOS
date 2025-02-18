//
//  OnBoardingViewController.swift
//  echog
//
//  Created by minsong kim on 1/11/25.
//

import Combine
import UIKit
import SnapKit

class OnBoardingViewController: UIViewController, View {
    var store: OnBoardingStore
    private var cancellables = Set<AnyCancellable>()
    
    required init(store: OnBoardingStore) {
        self.store = store
        
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
        view.backgroundColor = .systemBackground
        
        configureBackgoundView()
        configureView()
        setUpTapGesture()
        setUpBind()
    }
    
    private func setUpBind() {
        store.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.render(newState)
            }
            .store(in: &cancellables)
    }
    
    private func render(_ state: OnBoardingReducer.State) {
        //뷰 관리
        updateUI(image: state.image, title: state.title, isStartButton: state.isStartButton)
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
                
                let nextPage = self.store.state.page
                self.store.dispatch(.goToNext(nextPage))
            }
            .store(in: &cancellables)
        
        startButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.store.dispatch(.goToStart)
            }
            .store(in: &cancellables)
    }
    
    private func configureBackgoundView() {
        let backgoundView = UIImageView(image: UIImage(resource: .background))
        
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
//    let vc = OnBoardingViewController(coordinator: OnBoardingCoordinator(navigationController: UINavigationController()))
//    
//    return vc
//}
