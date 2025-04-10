//
//  EchogUITest.swift
//  EchogUITest
//
//  Created by minsong kim on 11/12/24.
//

import XCTest

final class EchogUITest: XCTestCase {

    override func setUpWithError() throws {
        //각 테스트 전에 실행, 실패 시 테스트 X
        continueAfterFailure = false

        //앱 초기화, 실행
        let app = XCUIApplication()
        app.launch()
    }

    func testCalendarViewExists() throws {
        let app = XCUIApplication()
        app.launch()
        
        // 캘린더 뷰가 화면에 존재하는지 확인.
        let calendarView = app.otherElements["calendarView"]
        XCTAssertTrue(calendarView.exists, "Calendar view should exist on the screen.")
    }
    
    func testCalendarViewDateSelection() throws {
        let app = XCUIApplication()
        app.launch()
        
        // 특정 날짜를 탭하여 선택해 보는 테스트
        let targetDate = app.staticTexts["15"]
        XCTAssertTrue(targetDate.exists, "Target date should be selectable in the calendar view.")
        
        targetDate.tap()
    }
}
