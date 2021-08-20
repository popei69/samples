//
//  ViewModel.swift
//  ViewSample
//
//  Created by Benoit PASQUIER on 20/08/2021.
//

protocol ViewModelProtocol: AnyObject {
    func addFruit(_ text: String)
    func removeFruit(_ text: String)
    func checkout()
}

class ViewModel: ViewModelProtocol {
    private var bag: [String: Int] = [:]
    func addFruit(_ text: String) {
        let newValue = (bag[text] ?? 0) + 1
        bag[text] = newValue
        print("\(text) \(newValue)")
    }
    
    func removeFruit(_ text: String) {
        guard let value = bag[text] else { return }
        let newValue = max(value - 1, 0)
        bag[text] = value
        print("\(text) \(newValue)")
    }
    
    func checkout() {
        print(bag)
    }
}
