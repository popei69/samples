//
//  DeeplinkCoordinator.swift
//  DeeplinkSample
//
//  Created by Benoit PASQUIER on 05/02/2022.
//

import Foundation

protocol DeeplinkCoordinatorProtocol {
    func handle(_ url: URL)
}

final class DeeplinkCoordinator {
    
    let handlers: [DeeplinkHandlerProtocol]
    
    init(handlers: [DeeplinkHandlerProtocol]) {
        self.handlers = handlers
    }
}

extension DeeplinkCoordinator: DeeplinkCoordinatorProtocol {
    func handle(_ url: URL) {
        guard let handler = handlers.first(where: { $0.canOpenURL(url) }) else {
            return
        }
              
        handler.openUrl(url)
    }
}
