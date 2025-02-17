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
    var store: InformationStore
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "먼저 당신의 정보를\n알고 싶어요"
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
        view.backgroundColor = .white
        
        configureTitleLabel()
        setUpTapGesture()
    }
    
    private func setUpTapGesture() {
        view.throttleTapGesturePublisher()
            .sink { [weak self] _ in
                guard let self else {
                    return
                }
                
                self.store.dispatch(.goToFillInformation)
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
