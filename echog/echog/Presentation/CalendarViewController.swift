//
//  ViewController.swift
//  echog
//
//  Created by minsong kim on 9/18/24.
//

import UIKit
import SnapKit

class CalendarViewController: UIViewController {
    private let calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.fontDesign = .rounded
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.accessibilityIdentifier = "calendarView"
        
        return calendarView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCalendarView()
    }

    private func configureCalendarView() {
        view.addSubview(calendarView)
        
        calendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

#Preview {
    let vc = CalendarViewController()
    
    return vc
}
