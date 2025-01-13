//
//  InformationLoadingViewController.swift
//  echog
//
//  Created by minsong kim on 1/11/25.
//

import Combine
import UIKit
import SnapKit

class InformationLoadingViewController: UIViewController {
    private var state = CurrentValueSubject<InformationLoadingState, Never>(.start)
    private let intent = PassthroughSubject<InformationLoadingIntent, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .semiboldSubheadline22
        label.numberOfLines = 2
        
        return label
    }()
    
    weak var coordinator: InformationCoordinator!
    
    init(coordinator: InformationCoordinator!) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTitleLabel()
        setUpBindings()
        setUpTapGesture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        intent.send(.goToFinish)
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
            self?.titleLabel.text = state.text
        }
        .store(in: &cancellables)
    }
    
    private func setUpTapGesture() {
        view.throttleTapGesturePublisher()
            .sink { [weak self] _ in
                self?.coordinator.pushInformationViewController()
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
