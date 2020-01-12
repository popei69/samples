//
//  CurrencyItemView.swift
//  SwiftUI-MVVM
//
//  Created by Benoit PASQUIER on 12/01/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import SwiftUI

struct CurrencyItemView: View {
    
    @ObservedObject var viewModel: CurrencyItemViewModel
    
    init(viewModel: CurrencyItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Text(viewModel.title)
            Spacer()
            Text(viewModel.value)
        }
    }
}

struct CurrencyItemView_Previews: PreviewProvider {
    static var previews: some View {
        let currency = Currency(iso: "USD", rate: 1.3)
        let viewModel = CurrencyItemViewModel(currency: currency)
        return CurrencyItemView(viewModel: viewModel)
    }
}
