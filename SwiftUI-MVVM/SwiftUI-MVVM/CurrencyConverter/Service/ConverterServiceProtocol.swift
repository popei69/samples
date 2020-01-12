//
//  ConverterServiceProtocol.swift
//  SwiftUI-MVVM
//
//  Created by Benoit PASQUIER on 11/01/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Combine

protocol CurrencyServiceProtocol {
    func converter(basedOn currencyIso: String) -> AnyPublisher<Converter,Error>
}

struct FileCurrencyService: CurrencyServiceProtocol {
    
    private let fileName = "sample"
    
    func converter(basedOn currencyIso: String) -> AnyPublisher<Converter, Error> {
        return FileManager.readJsonFile(from: fileName)
            .tryCompactMap { data -> Converter in 
                let jsonDecoder = JSONDecoder()
                return try jsonDecoder.decode(Converter.self, from: data)
            }
            .eraseToAnyPublisher()
    }
}
