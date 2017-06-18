//
//  MainVCViewModel.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import UIKit

protocol MainVCViewModelProtocol : class {
    func reloadTableView()
    func error(_ error: Error)
    func show(controller: UIViewController)
}

final class MainVCViewModel : NSObject {

    weak var delegate: MainVCViewModelProtocol?
    private(set) var tableViewItemsCount = 0
    let tableViewCellName = "MainVCCell"

    fileprivate let server = ServerMainVC()
    fileprivate var tableViewData = [ServerMainVCModel]()
    fileprivate var showedTableViewData = [ServerMainVCModel]() {
        didSet {
            tableViewItemsCount = showedTableViewData.count
        }
    }

    func getData() {
        server.campains { [weak self] result -> Void in
            guard let welf = self, let delegate = welf.delegate else { return }
            if case .result(let models) = result {
                welf.tableViewData = models
                welf.showedTableViewData = models
                delegate.reloadTableView()
            } else if case .error(let error) = result {
                delegate.error(error)
            }
        }
    }
}

extension MainVCViewModel : UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        if !searchText.isBlank {
            showedTableViewData = tableViewData.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        } else {
            showedTableViewData = tableViewData
        }
        delegate?.reloadTableView()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.showsCancelButton = false
        showedTableViewData = tableViewData
        delegate?.reloadTableView()
    }
}

extension MainVCViewModel : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItemsCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainVCCell.height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellName) as? MainVCCell else { return UITableViewCell() }
        cell.model = showedTableViewData[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let charts = Storyboards.charts as? ChartsVC {
            let model = showedTableViewData[indexPath.row]
            charts.campainID = model.id
            charts.campainType = model.type
            delegate?.show(controller: charts)
        } else {
            delegate?.error(NSError(domain: "Can't get \(Storyboards.Name.charts) storyboard", code: 0, userInfo: nil))
        }
    }
}
