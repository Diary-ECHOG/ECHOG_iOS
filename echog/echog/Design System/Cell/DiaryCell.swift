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
        
        configureContentView()
        configureLabels()
    }
    
    private func configureContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        // 그림자용 레이어가 보이도록 false
        layer.masksToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 이전에 추가한 shadow 레이어들 제거
        layer.sublayers?
            .filter { $0.name?.hasPrefix("shadow_") ?? false }
            .forEach { $0.removeFromSuperlayer() }
        
        // Figma Drop shadow 1 (Y:14, Blur:32, Opacity:12%)
        addShadowLayer(offset: .init(width: 0, height: 14),
                       blur:    32,
                       spread:  0,
                       opacity: 0.12,
                       name:    "shadow_1")
        
        // Drop shadow 2 (Y:10, Blur:14, Opacity:6%)
        addShadowLayer(offset: .init(width: 0, height: 10),
                       blur:    14,
                       spread:  0,
                       opacity: 0.06,
                       name:    "shadow_2")
        
        // Drop shadow 3 (spread:1, Opacity:3%)
        addShadowLayer(offset: .zero,
                       blur:    0,
                       spread:  1,
                       opacity: 0.03,
                       name:    "shadow_3")
        
        // Drop shadow 4 (Blur:1, Opacity:20%)
        addShadowLayer(offset: .zero,
                       blur:    1,
                       spread:  0,
                       opacity: 0.20,
                       name:    "shadow_4")
    }
    
    private func addShadowLayer(offset: CGSize,
                                blur: CGFloat,
                                spread: CGFloat,
                                opacity: Float,
                                name: String) {
        let layerRect = bounds.insetBy(dx: -spread, dy: -spread)
        let path = UIBezierPath(roundedRect: layerRect, cornerRadius: contentView.layer.cornerRadius).cgPath
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.name           = name
        shadowLayer.path           = path
        shadowLayer.fillColor      = contentView.backgroundColor?.cgColor
        shadowLayer.shadowColor    = UIColor.shadow.cgColor
        shadowLayer.shadowOffset   = offset
        shadowLayer.shadowRadius   = blur / 2
        shadowLayer.shadowOpacity  = opacity
        shadowLayer.shadowPath     = path
        
        // contentView 바로 아래에 추가하려면 index: 0
        layer.insertSublayer(shadowLayer, at: 0)
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
