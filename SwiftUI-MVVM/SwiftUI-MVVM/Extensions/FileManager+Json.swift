//
//  FileManager+Json.swift
//  SwiftUI-MVVM
//
//  Created by Benoit PASQUIER on 11/01/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Combine

extension FileManager {
    
    static func readJsonFile(from fileName: String) -> AnyPublisher<Data, Error> {
        
        return Just(fileName)
            .compactMap { Bundle.main.path(forResource: $0, ofType: "json") }
            .tryCompactMap { filePath -> Data in
                let url = URL(fileURLWithPath: filePath)
                return try Data(contentsOf: url, options: .mappedIfSafe)
            }
            .eraseToAnyPublisher()
    }
}
