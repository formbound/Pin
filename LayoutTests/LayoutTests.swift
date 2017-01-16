//
//  LayoutTests.swift
//  LayoutTests
//
//  Created by David Ask on 2017-01-16.
//  Copyright © 2017 Formbound. All rights reserved.
//

import XCTest
@testable import Layout

class LayoutTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}


class ViewController: UIViewController {
    
    let label = UIView()
    
    lazy var labelCenterYConstraint: NSLayoutConstraint = {
        return self.label.layout.centerY == self.view.layout.centerY
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.layout.top == view.layout.topMargin,
            label.layout.centerX == view.layout.centerX,
            label.layout.left >= view.layout.leftMargin,
            label.layout.right <= view.layout.rightMargin,
            ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewdidLoad(animated)
        
        labelCenterYConstraint.isActive = true
    }
}
