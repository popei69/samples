//
//  ContentView.swift
//  SwiftUI-MVVM
//
//  Created by Benoit PASQUIER on 07/01/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import SwiftUI

struct CurrenciesListView: View {
    @ObservedObject var viewModel: CurrenciesListViewModel
    
    init(viewModel: CurrenciesListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(viewModel.rates, content: CurrencyItemView.init(viewModel:))
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(viewModel.title)
        }
    }
}

struct CurrenciesListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = CurrenciesListViewModel(converterService: FileCurrencyService())
        return CurrenciesListView(viewModel: viewModel)
    }
}
