//
//  Converter.swift
//  SwiftUI-MVVM
//
//  Created by Benoit PASQUIER on 07/01/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

enum CurrencySymbol: String {
    case GBP, USD, EUR 
    
    var symbol: String {
        switch self {
        case .EUR: return "€"
        case .USD: return "$"
        case .GBP: return "£"
        }
    }
}

struct Currency {
    let iso: String
    let rate: Double
}
