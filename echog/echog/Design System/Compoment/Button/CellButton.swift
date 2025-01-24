//
//  CellButton.swift
//  echog
//
//  Created by minsong kim on 1/24/25.
//

import UIKit
import SnapKit

class CellButton: UIButton {
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = .regularTitle15
        label.textColor = .slate800
        
        return label
    }()
    
    private let subTitleView: UILabel = {
        let label = UILabel()
        label.font = .regularTitle15
        label.textColor = .countBlue
        
        return label
    }()
    
    private let subImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .slate500
        
        return view
    }()
    
    init(frame: CGRect = .zero, title: String, subTitle: String, image: UIImage?) {
        self.titleView.text = title
        self.subTitleView.text = subTitle
        self.subImageView.image = image
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        self.addSubview(titleView)
        self.addSubview(subTitleView)
        self.addSubview(subImageView)
        
        titleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        subTitleView.snp.makeConstraints { make in
            make.leading.equalTo(titleView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        subImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
    }
    
    func changeSubTitle(subTitle: String) {
        subTitleView.text = subTitle
    }
}
