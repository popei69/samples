//
//  DeeplinkHandlerProtocol.swift
//  DeeplinkSample
//
//  Created by Benoit PASQUIER on 05/02/2022.
//

import Foundation

protocol DeeplinkHandlerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL)
}
