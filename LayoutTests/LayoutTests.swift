//
//  LayoutTests.swift
//  LayoutTests
//
//  Created by David Ask on 2016-12-02.
//  Copyright © 2016 Formbound. All rights reserved.
//

import XCTest
@testable import Layout

class LayoutTests: XCTestCase {

    let view = UIView()

    let label = UILabel()

    lazy var labelCenterYConstraint: NSLayoutConstraint = {
        return self.label.layout.centerY == self.view.layout.centerY
    }()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {


        let constraints = [
            label.layout.top          == view.layout.topMargin ~ UILayoutPriorityDefaultHigh,
            label.layout.centerX      == view.layout.centerX,
            label.layout.left         >= view.layout.leftMargin,
            label.layout.right        <= view.layout.rightMargin,
        ]
        

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
