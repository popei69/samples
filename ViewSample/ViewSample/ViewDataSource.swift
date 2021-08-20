//
//  ViewDataSource.swift
//  ViewSample
//
//  Created by Benoit PASQUIER on 20/08/2021.
//

import UIKit

final class ViewDataSource: NSObject, UITableViewDataSource {
    
    let data = ["🍎", "🍇", "🍌", "🍋", "🍍", "🥥"]
    weak var viewModel: ViewModelProtocol?
    init(viewModel: ViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseIdentifier, for: indexPath) as! CustomCell
        let item = data[indexPath.row]
        cell.setTitle(item)
        cell.didTapAdd = { [weak self] in 
            self?.viewModel?.addFruit(item)
        }
        cell.didTapRemove = { [weak self] in 
            self?.viewModel?.removeFruit(item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
