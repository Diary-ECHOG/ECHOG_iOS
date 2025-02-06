//
//  TermsViewController.swift
//  echog
//
//  Created by minsong kim on 1/31/25.
//

import Combine
import UIKit
import SnapKit
//import WebKit

class TermsViewController: UIViewController, View {
    var store: InformationStore
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약관 동의가 필요해요."
        label.font = .semiboldSubheadline22
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let nextButton = MainButton(title: "확인", isEnabled: true)
    
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
        bind()
    }
    
    private func bind() {
        nextButton.publisher(for: .touchUpInside)
            .sink { [weak self] in
                self?.store.dispatch(.goToNextPage)
            }
            .store(in: &cancellables)
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}

//#Preview {
//    let vc = TermsViewController()
//    
//    return vc
//}
