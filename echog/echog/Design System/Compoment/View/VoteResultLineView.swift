//
//  VoteResultLineView.swift
//  echog
//
//  Created by minsong kim on 2/13/25.
//

import UIKit
import SnapKit

struct VoteOption {
    let title: String
    let votes: Int
    let percentage: Int
}

class VoteResultLineView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.font = .mediumTitle13
        label.textColor = .slate800
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .right
        label.font = .mediumTitle13
        label.textColor = .slate800
        
        return label
    }()
    
    private let progressView: UIProgressView = {
        let view = UIProgressView()
        view.tintColor = .blue100
        view.trackTintColor = .slate25
        
        return view
    }()
    
    convenience init(frame: CGRect = .zero, options: VoteOption) {
        self.init(frame: frame)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        self.titleLabel.text = options.title
        self.countLabel.text = "\(options.votes)표 \(options.percentage)%"
        self.progressView.progress = Float(options.percentage) / 100
        
        configureUI()
    }
    
    private func configureUI() {
        self.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        self.addSubview(progressView)
        self.addSubview(titleLabel)
        self.addSubview(countLabel)
        
        progressView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
        }
    }
}
