//
//  LogInCompleteViewController.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import UIKit
import SnapKit

class LogInCompleteViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.setTextWithLineSpacing("오늘도\n외치러 가볼까요?", font: .semiboldSubheadline22, lineSpacing: 4)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgoundView()
        configureTitleLabel()
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

#Preview {
    let vc = LogInCompleteViewController()
    
    return vc
}
