//
//  UIView+.swift
//  echog
//
//  Created by minsong kim on 1/11/25.
//

import Combine
import UIKit

extension UIView {
    func throttleTapGesturePublisher() -> Publishers.Throttle<UITapGestureRecognizer.GesturePublisher<UITapGestureRecognizer>, RunLoop> {
        return UITapGestureRecognizer.GesturePublisher(recognizer: .init(), view: self)
            .throttle(
                for: .seconds(1),
                scheduler: RunLoop.main,
                latest: false
            )
    }
}
