//
//  CurrenciesListViewModel.swift
//  SwiftUI-MVVM
//
//  Created by Benoit PASQUIER on 11/01/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Combine


class CurrenciesListViewModel: ObservableObject, Identifiable {
    
    @Published var rates: [CurrencyItemViewModel] = []
    @Published var title: String = ""
    
    private let converterService: CurrencyServiceProtocol
    private var disposables = Set<AnyCancellable>()
    
    init(converterService: CurrencyServiceProtocol) {
        self.converterService = converterService
        
        fetchCurrencies()
    }
    
    func fetchCurrencies(for currencyIso: String = "GBP") {
        
        converterService
            .converter(basedOn: currencyIso)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.rates = []
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] converter in 
                guard let self = self else { return }
                self.rates = converter.currencies
                    .sorted(by: { (left, right) -> Bool in
                        left.iso < right.iso
                    })
                    .map({ CurrencyItemViewModel.init(currency: $0) })
                
                if let symbol = converter.baseSymbol {
                    self.title = "Currency Exchange \(symbol)"
                }
            })
            .store(in: &disposables)
    }
}
