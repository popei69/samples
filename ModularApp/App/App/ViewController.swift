//
//  ViewController.swift
//  App
//
//  Created by Benoit PASQUIER on 28/09/2019.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import UIKit
import Core

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let products = ProductService().getAllProducts()
        print(products)
    }
}

