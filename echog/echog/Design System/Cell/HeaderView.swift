//
//  HeaderView.swift
//  echog
//
//  Created by minsong kim on 12/25/24.
//

import UIKit
import SnapKit

class HeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldLargetitle17
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabelUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel(text: String) {
        titleLabel.text = text
    }

    func configureLabelUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
        }
    }
}
