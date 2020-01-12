//
//  CurrencyItemViewModel.swift
//  SwiftUI-MVVM
//
//  Created by Benoit PASQUIER on 12/01/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Combine

class CurrencyItemViewModel: ObservableObject, Identifiable {
    
    @Published var title: String = ""
    @Published var value: String = ""
    
    init(currency: Currency) {
        title = currency.iso
        value = "\(currency.rate)"
    } 
}
