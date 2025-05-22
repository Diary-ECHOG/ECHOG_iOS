//
//  ShadowButton.swift
//  echog
//
//  Created by minsong kim on 5/22/25.
//

import UIKit

class ShadowButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        // 기존에 추가한 shadow 레이어들 제거
        layer.sublayers?
            .filter { $0.name?.hasPrefix("shadow_") ?? false }
            .forEach { $0.removeFromSuperlayer() }

        // Figma 그림자 1
        addShadowLayer(offset: CGSize(width: 0, height: 14),
                       blur:    32,
                       spread:  0,
                       opacity: 0.12,
                       name:    "shadow_1")

        // Figma 그림자 2
        addShadowLayer(offset: CGSize(width: 0, height: 10),
                       blur:    14,
                       spread:  0,
                       opacity: 0.06,
                       name:    "shadow_2")

        // Figma 그림자 3 (spread만 1px)
        addShadowLayer(offset: .zero,
                       blur:    0,
                       spread:  1,
                       opacity: 0.03,
                       name:    "shadow_3")

        // Figma 그림자 4 (spread만 0, opacity 20%)
        addShadowLayer(offset: .zero,
                       blur:    0,
                       spread:  0,
                       opacity: 0.20,
                       name:    "shadow_4")
    }

    private func addShadowLayer(offset: CGSize,
                                blur: CGFloat,
                                spread: CGFloat,
                                opacity: Float,
                                name: String)
    {
        let shadowLayer = CAShapeLayer()
        shadowLayer.name = name

        // spread 적용: inset이 음수면 외곽으로 확대
        let rect = bounds.insetBy(dx: -spread, dy: -spread)
        shadowLayer.path = UIBezierPath(roundedRect: rect,
                                        cornerRadius: layer.cornerRadius).cgPath
        
        shadowLayer.fillColor     = backgroundColor?.cgColor
        shadowLayer.shadowColor   = UIColor.shadow.cgColor
        shadowLayer.shadowPath    = shadowLayer.path
        shadowLayer.shadowOffset  = offset
        shadowLayer.shadowRadius  = blur / 2  // blur 반값이 radius
        shadowLayer.shadowOpacity = opacity

        // 버튼 레이어 맨 아래(insert) 또는 위(add) 원하는 위치에 넣을 수 있음
        layer.insertSublayer(shadowLayer, at: 0)
    }
}
