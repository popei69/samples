//
//  Converter.swift
//  SwiftUI-MVVM
//
//  Created by Benoit PASQUIER on 11/01/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct Converter {
    let base: String
    let date: String
    var currencies: [Currency]
    
    var baseSymbol: String? {
        CurrencySymbol(rawValue: base.uppercased())?.symbol
    }
}

extension Converter: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Keys.self)
        let base = try container.decode(String.self, forKey: .base)
        let date = try container.decode(String.self, forKey: .date)
        let currencies = try container.decode([String: Double].self, forKey: .rates)
            .compactMap({ Currency(iso: $0.0, rate: $0.1) })
        
        self.init(base: base, date: date, currencies: currencies)
    }
    
    enum Keys: String, CodingKey {
        case base
        case date
        case rates
    }
}
