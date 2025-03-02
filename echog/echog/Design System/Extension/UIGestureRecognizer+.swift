//
//  UIGestureRecognizer+.swift
//  echog
//
//  Created by minsong kim on 1/11/25.
//

import Combine
import UIKit

extension UITapGestureRecognizer {
    final class GestureSubscription<S: Subscriber, TapRecognizer: UITapGestureRecognizer>: Subscription where S.Input == TapRecognizer {
        private var subscriber: S?
        private let recognizer: TapRecognizer
        
        init(subscriber: S, recognizer: TapRecognizer, view: UIView) {
            self.subscriber = subscriber
            self.recognizer = recognizer
            
            recognizer.addTarget(self, action: #selector(eventHandler))
            view.addGestureRecognizer(recognizer)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
        }
        
        @objc func eventHandler() {
            _ = subscriber?.receive(recognizer)
        }
    }

}

extension UITapGestureRecognizer {
    struct GesturePublisher<TapRecognizer: UITapGestureRecognizer>: Publisher {
        typealias Output = TapRecognizer
        typealias Failure = Never
        
        private let recognizer: TapRecognizer
        private let view: UIView
        
        init(recognizer: TapRecognizer, view: UIView) {
            self.recognizer = recognizer
            self.view = view
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, TapRecognizer == S.Input {
            let subscription = GestureSubscription(
                subscriber: subscriber,
                recognizer: recognizer,
                view: view
            )
            subscriber.receive(subscription: subscription)
        }
    }
}

extension UIGestureRecognizer {
    struct GesturePublisher: Publisher {
        typealias Output = UIGestureRecognizer
        typealias Failure = Never
        
        let gestureRecognizer: UIGestureRecognizer
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIGestureRecognizer == S.Input {
            let subscription = GestureSubscription(subscriber: subscriber, gestureRecognizer: gestureRecognizer)
            subscriber.receive(subscription: subscription)
        }
    }
    
    private class GestureSubscription<S: Subscriber>: Subscription where S.Input == UIGestureRecognizer, S.Failure == Never {
        var subscriber: S?
        let gestureRecognizer: UIGestureRecognizer
        
        init(subscriber: S, gestureRecognizer: UIGestureRecognizer) {
            self.subscriber = subscriber
            self.gestureRecognizer = gestureRecognizer
            gestureRecognizer.addTarget(self, action: #selector(handleGesture))
        }
        
        func request(_ demand: Subscribers.Demand) {
            // 별도의 요청 처리는 필요하지 않습니다.
        }
        
        func cancel() {
            subscriber = nil
        }
        
        @objc func handleGesture() {
            _ = subscriber?.receive(gestureRecognizer)
        }
    }
    
    func publisher() -> GesturePublisher {
        return GesturePublisher(gestureRecognizer: self)
    }
}
