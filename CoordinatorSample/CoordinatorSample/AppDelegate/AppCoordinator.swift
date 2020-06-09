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
        let router = Router(navigationController: UINavigationController())
        let myCoordinator = FirstCoordinator(router: router)

        // store child coordinator
        self.start(coordinator: myCoordinator)

        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
    }
}
