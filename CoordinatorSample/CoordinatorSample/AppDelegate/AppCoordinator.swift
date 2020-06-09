//
//  AppCoordinator.swift
//  CoordinatorSample
//
//  Created by Benoit Pasquier on 9/6/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator : BaseCoordinator {

    let window : UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        // preparing root view
        let navigationController = UINavigationController()
        let myCoordinator = FirstCoordinator(navigationController: navigationController)

        // store child coordinator
        self.store(coordinator: myCoordinator)
        myCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        // detect when free it
        myCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: myCoordinator)
        }
    }
}
