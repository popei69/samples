//
//  VideoDeeplinkHandler.swift
//  DeeplinkSample
//
//  Created by Benoit PASQUIER on 13/02/2022.
//

import Foundation
import UIKit

final class VideoDeeplinkHandler: DeeplinkHandlerProtocol {
    
    private weak var rootViewController: UIViewController?
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - DeeplinkHandlerProtocol
    
    func canOpenURL(_ url: URL) -> Bool {
        return url.absoluteString.hasPrefix("deeplink://videos")
    }
    func openURL(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }
        
        let viewController = UIViewController()
        switch url.path {
        case "/new":
            viewController.title = "Video Editing"
            viewController.view.backgroundColor = .orange
        default:
            viewController.title = "Video Listing"
            viewController.view.backgroundColor = .cyan
        }
        
        // mock the navigation
        rootViewController?.present(viewController, animated: true)
    }
}
