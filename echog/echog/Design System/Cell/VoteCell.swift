//
//  VoteCell.swift
//  echog
//
//  Created by minsong kim on 1/8/25.
//

import UIKit
import SnapKit

class VoteCell: UITableViewCell {
    static let identifier = "VoteCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiboldTitle15
        
        return label
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumTitle14
        label.textColor = .grayscale70
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .regularTitle13
        label.textColor = .grayscale50Caption
        
        return label
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "MM월 dd일 E요일"
        
        return dateFormatter
    }()
    
    private let voteNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .regularTitle13
        label.textColor = .grayscale50Caption
        label.textAlignment = .right
        
        return label
    }()
    
    private func configureLabels() {
        self.addSubview(titleLabel)
        self.addSubview(contentsLabel)
        self.addSubview(dateLabel)
        self.addSubview(voteNumberLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.height.equalTo(22)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(16)
        }
        
        voteNumberLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(dateLabel)
        }
    }
    
    func configureCells(title: String, contents: String, date: Date, voteNumber: Int) {
        titleLabel.text = title
        contentsLabel.text = contents
        dateLabel.text = dateFormatter.string(from: date)
        voteNumberLabel.text = "\(voteNumber)명 투표"
        
        configureLabels()
    }
}
