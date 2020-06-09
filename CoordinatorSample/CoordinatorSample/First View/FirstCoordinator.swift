//
//  FirstCoordinator.swift
//  CoordinatorSample
//
//  Created by Benoit Pasquier on 9/6/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import UIKit

class FirstCoordinator : BaseCoordinator {

    var navigationController: UINavigationController?

    init(navigationController :UINavigationController?) {
        self.navigationController = navigationController
    }

    override func start() {

        // prepare the associated view and injecting its viewModel
        let viewModel = FirstViewModel()
        let viewController = FirstViewController(viewModel: viewModel)

        // for specific events from viewModel, define next navigation
        viewModel.didSelect = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.showNextScreen(in: strongSelf.navigationController)
        }

        // if user navigates back, view should be released, so does the coordinator, flow is completed
        viewModel.didTapBack = { [weak self] in
            self?.isCompleted?()
        }

        navigationController?.pushViewController(viewController, animated: true)
    }

    // we can go further in our flow if we need to
    func showNextScreen(in navigationController: UINavigationController?) {
//        let newCoordinator = NewCoordinator(product: product, navigationController: navigationController)
//        self.store(coordinator: newCoordinator)
    }
}
