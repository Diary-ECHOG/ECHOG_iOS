//
//  DiaryCell.swift
//  echog
//
//  Created by minsong kim on 12/25/24.
//

import UIKit
import SnapKit

class DiaryCell: UICollectionViewCell, Identifiable {
    static let identifier = "DiaryCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldTitle15
        label.textColor = .slate800
        
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumTitle14
        label.textColor = .slate600
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .regularTitle13
        label.textColor = .slate400
        
        return label
    }()
    
    func configureTexts(title: String, content: String, date: String) {
        titleLabel.text = title
        contentLabel.text = content
        dateLabel.text = date
        
        configureCellShadowAndCornerRadius()
        configureLabels()
    }
    
    private func configureCellShadowAndCornerRadius() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
    
    private func configureLabels() {
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(dateLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
