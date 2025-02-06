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
    var store: InformationLoadingStore
    private var cancellables = Set<AnyCancellable>()
    
    required init(reducer: InformationLoadingReducer) {
        self.store = InformationLoadingStore(reducer: reducer)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .semiboldSubheadline22
        label.numberOfLines = 2
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTitleLabel()
        setUpBind()
        setUpTapGesture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.store.dispatch(.changeWelcomeText)
    }
    
    private func setUpBind() {
        store.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.render(newState)
            }
            .store(in: &cancellables)
    }
    
    private func render(_ state: InformationLoadingReducer.State) {
        //뷰 관리
        titleLabel.text = state.text
    }
    
    private func setUpTapGesture() {
        view.throttleTapGesturePublisher()
            .sink { [weak self] _ in
                guard let self else {
                    return
                }
                
                let newPage = self.store.state.page
                self.store.dispatch(.goToNext(newPage))
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
