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
    }
}

