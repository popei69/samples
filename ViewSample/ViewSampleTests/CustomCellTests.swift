//
//  CustomCellTests.swift
//  ViewSampleTests
//
//  Created by Benoit PASQUIER on 20/08/2021.
//

import XCTest
@testable import ViewSample

class CustomCellTests: XCTestCase {

    func test_did_tap_add_succeed_when_touch_up_inside() {
        // Given:
        let tapAddExpectation = expectation(description: #function)
        let cell = CustomCell(style: .default, reuseIdentifier: "id")
        cell.didTapAdd = {
            tapAddExpectation.fulfill()
        }
    
        // When:
        cell.addButton.sendActions(for: .touchUpInside)
        
        // Then:
        wait(for: [tapAddExpectation], timeout: 0.1)
    }
    
    func test_did_tap_add_fail_when_touch_down() {
        // Given:
        let cell = CustomCell(style: .default, reuseIdentifier: "id")
        cell.didTapAdd = {
            XCTFail("unexpected trigger")
        }
    
        // When:
        cell.addButton.sendActions(for: .touchDown)
    }
    
    func test_did_tap_remove_succeed_when_touch_up_inside() {
        // Given:
        let tapRemoveExpectation = expectation(description: #function)
        let cell = CustomCell(style: .default, reuseIdentifier: "id")
        cell.didTapRemove = {
            tapRemoveExpectation.fulfill()
        }
    
        // When:
        cell.removeButton.sendActions(for: .touchUpInside)
        
        // Then:
        wait(for: [tapRemoveExpectation], timeout: 0.1)
    }
    
    func test_did_tap_remove_fail_when_touch_down() {
        // Given:
        let cell = CustomCell(style: .default, reuseIdentifier: "id")
        cell.didTapRemove = {
            XCTFail("unexpected trigger")
        }
    
        // When:
        cell.removeButton.sendActions(for: .touchDown)
        
        // Then:
        wait(for: [], timeout: 0.1)
    }

}
