//
//  UnderlineSegmentedControl.swift
//  echog
//
//  Created by minsong kim on 1/8/25.
//

import UIKit

class UnderlineSegmentedControl: UISegmentedControl {
    private lazy var underlineBackView: UIView = {
        let width = self.bounds.width
        let height = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 1.0
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        
        view.backgroundColor = .slate100
        self.addSubview(view)
        
        return view
    }()
    
    private lazy var underlineView: UIView = {
        let width = self.bounds.width / CGFloat(self.numberOfSegments)
        let height = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 1.0
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        
        view.backgroundColor = .black
        self.addSubview(view)
        
        return view
    }()
    
    override init(items: [Any]?) {
        super.init(items: items)
        
        self.removeDivider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
        
        UIView.animate(withDuration: 0.1) {
            self.underlineView.frame.origin.x = underlineFinalXPosition
        }
    }
    
    private func removeDivider() {
        let image = UIImage()
        
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
}
