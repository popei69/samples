//
//  ViewControllerTests.swift
//  ViewSampleTests
//
//  Created by Benoit PASQUIER on 20/08/2021.
//

import XCTest
@testable import ViewSample

class ViewControllerTests: XCTestCase {
    
    private var sut: ViewController!
    fileprivate var viewModel: MockViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MockViewModel()
        sut = ViewController(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testTapCheckout() {
        // Given:
        let tapCheckoutExpectation = expectation(description: #function)
        XCTAssertEqual(viewModel.checkoutCalled, 0)
        viewModel.didCallCheckout = { counter in
            XCTAssertEqual(counter, 1)
            tapCheckoutExpectation.fulfill()
        }
        
        let tapGestureRecognizer = sut.checkoutView.gestureRecognizers?.first as? UISwipeGestureRecognizer
        XCTAssertNotNil(tapGestureRecognizer, "Missing tap gesture")
        
        // When:
        tapGestureRecognizer?.state = .ended
        
        // Then:
        wait(for: [tapCheckoutExpectation], timeout: 0.1)
    }
}

fileprivate class MockViewModel: ViewModelProtocol {
    var addFruitCalled = 0
    var didCallAddFruit: ((Int) -> Void)?
    func addFruit(_ text: String) {
        addFruitCalled += 1
        didCallAddFruit?(addFruitCalled)
    }
    
    var removeFruitCalled = 0
    var didCallRemoveFruit: ((Int) -> Void)?
    func removeFruit(_ text: String) {
        removeFruitCalled += 1
        didCallRemoveFruit?(removeFruitCalled)
    }
    
    var checkoutCalled = 0
    var didCallCheckout: ((Int) -> Void)?
    func checkout() {
        checkoutCalled += 1
        didCallCheckout?(checkoutCalled)
    }
}

extension UIGestureRecognizer {
    
    func forceTrigger() throws {
        let gestureRecognizerTarget: AnyClass? = NSClassFromString("UIGestureRecognizerTarget")
        
        let targetIvar = class_getInstanceVariable(gestureRecognizerTarget, "_target")
        let actionIvar = class_getInstanceVariable(gestureRecognizerTarget, "_action")
        
        guard let targets = self.value(forKey: "targets") as? [Any] else {
            throw NSError(domain: "", code: 999, userInfo: [NSLocalizedDescriptionKey: "Cannot access targets"])
        }
        
        var hasPerformAction = false
        for gestureTarget in targets {
            guard let targetIvar = targetIvar,
               let actionIvar = actionIvar else {
                continue
            }
                
            if let target = object_getIvar(gestureTarget, targetIvar) as? NSObject,
               let action = object_getIvar(gestureTarget, actionIvar) as? Selector {
                target.perform(action)
                hasPerformAction = true
                break
            }
        }
        
        if !hasPerformAction {
            throw NSError(domain: "", code: 999, userInfo: [NSLocalizedDescriptionKey: "Cannot find target or action"])
        }
    }
}


class MockTapGestureRecognizer: UITapGestureRecognizer {
    
    var target: Any?
    var action: Selector?
    override func addTarget(_ target: Any, action: Selector) {
        self.target = target
        self.action = action
    }
    
    override var state: UIGestureRecognizer.State {
        didSet {
            forceTriggerAction()
        }
    }
    
    func forceTriggerAction() {
        guard let target = target as? NSObject,
              let action = action else { 
            return
        }
        
        target.perform(action)
    }
}
