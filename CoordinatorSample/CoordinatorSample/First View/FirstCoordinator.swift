//
//  FirstCoordinator.swift
//  CoordinatorSample
//
//  Created by Benoit Pasquier on 9/6/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

class FirstCoordinator : BaseCoordinator {

    let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    override func start() {

        // prepare the associated view and injecting its viewModel
        let viewModel = FirstViewModel()
        let viewController = FirstViewController(viewModel: viewModel)

        // for specific events from viewModel, define next navigation
        viewModel.didSelect = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.showNextScreen(in: strongSelf.router)
        }

        router.push(viewController, isAnimated: true, onNavigateBack: self.isCompleted)
    }

    // we can go further in our flow if we need to
    func showNextScreen(in router: RouterProtocol) {
        let newCoordinator = FirstCoordinator(router: router)
        self.start(coordinator: newCoordinator)
    }
}
