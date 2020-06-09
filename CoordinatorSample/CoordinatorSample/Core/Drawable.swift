//
//  Drawable.swift
//  CoordinatorSample
//
//  Created by Benoit Pasquier on 9/6/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
}
