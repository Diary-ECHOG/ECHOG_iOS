//
//  LogInCompleteViewController.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import Combine
import UIKit
import SnapKit

class LogInCompleteViewController: UIViewController, View {
    var store: LogInStore
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.setTextWithLineSpacing("오늘도\n외치러 가볼까요?", font: .semiboldSubheadline22, lineSpacing: 4)
        
        return label
    }()
    
    required init(store: LogInStore) {
        self.store = store
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureBackgoundView()
        configureTitleLabel()
        
        setUpTapGesture()
    }
    
    private func setUpTapGesture() {
        view.throttleTapGesturePublisher()
            .sink { [weak self] _ in
                guard let self else {
                    return
                }
                
                self.store.dispatch(.goToDiaryHome)
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
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

//#Preview {
//    let vc = LogInCompleteViewController()
//    
//    return vc
//}
