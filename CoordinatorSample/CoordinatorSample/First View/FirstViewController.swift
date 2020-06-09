//
//  ViewController.swift
//  CoordinatorSample
//
//  Created by Benoit Pasquier on 9/6/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

class FirstViewModel {
    
    var didSelect: (() -> ())?
    var didTapBack: (() -> ())?
    
    let backgroundColor: UIColor
    
    init() {
        self.backgroundColor = FirstViewModel.randomizeColor()
    }
    
    static func randomizeColor() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}

class FirstViewController: UIViewController {
    
    let viewModel: FirstViewModel
    
    required init(viewModel: FirstViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = viewModel.backgroundColor
        
        let button = UIButton(type: .custom)
        button.setTitle("Push new view", for: .normal)
        button.addTarget(self, action: #selector(FirstViewController.buttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 220),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        viewModel.didSelect?()
    }
}

