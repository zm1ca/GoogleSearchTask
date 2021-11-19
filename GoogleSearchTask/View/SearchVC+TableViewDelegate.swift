//
//  SearchVC+TableViewDelegate.swift
//  GoogleSearchTask
//
//  Created by Źmicier Fiedčanka on 19.11.21.
//

import UIKit

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func configureResultsTableView() {
        resultsTableView.register(GSSearchResultCell.self, forCellReuseIdentifier: GSSearchResultCell.reuseID)
        resultsTableView.delegate        = self
        resultsTableView.dataSource      = self
        resultsTableView.allowsSelection = false
        resultsTableView.backgroundColor = UIColor(named: "LightCyan")
        resultsTableView.layer.cornerRadius = 12
        resultsTableView.layer.borderColor  = UIColor.bdazzledBlue.cgColor
        resultsTableView.layer.borderWidth  = 2
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: GSSearchResultCell.reuseID, for: indexPath) as! GSSearchResultCell
        guard let viewModel = viewModel else { return UITableViewCell() }
        cell.textLabel?.text = viewModel.text(forCellAt: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search results"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .lightCyan
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .gunmetal
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.dataSource?.tableView(tableView, numberOfRowsInSection: 0) == 0 {
            return 0
        } else {
            return 50
        }
    }
}
