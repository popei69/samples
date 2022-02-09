//
//  DebugDeeplinkHandler.swift
//  DeeplinkSample
//
//  Created by Benoit PASQUIER on 05/02/2022.
//

import Foundation
import UIKit

final class DebugDeeplinkHandler: DeeplinkHandlerProtocol {
    
    let rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    func canOpenURL(_ url: URL) -> Bool {
        #if DEBUG
        return url.absoluteString.hasPrefix("deeplink://mock/")
        #else
        return false
        #endif
    }
    
    func openUrl(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }
        
        switch url.path {
        case "/video":
            handleVideoMock()
        default:
            print("no mock")
            break
        }
    }
}

extension DebugDeeplinkHandler {
    
    private func handleVideoMock() {
        let viewController = UIViewController()
        viewController.title = "Video"
        viewController.view.backgroundColor = .cyan
        
        if let navigationController = rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            rootViewController?.present(viewController, animated: true, completion: nil)
        }
    }
}
