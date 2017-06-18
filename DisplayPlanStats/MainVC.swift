//
//  MainVC.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit

final class MainVC: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!

    fileprivate let viewModel = MainVCViewModel()
    fileprivate var searchBarIsHidden = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Campaigns"
        initNavigationBar()
        initSearchBar()
        initTableView()
        initViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideSearchBar()
    }
}

// MARK: initialisations
private extension MainVC {

    func initNavigationBar() {
        let image = #imageLiteral(resourceName: "ic_settings").resizedProportionaly(to: CGSize(width: 25, height: 25))
        let barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = barButton
    }

    func initViewModel() {
        viewModel.delegate = self
    }

    func initSearchBar() {
        searchBar.delegate = viewModel
    }

    func initTableView() {
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.register(nib: viewModel.tableViewCellName)
    }

    func hideSearchBar() {
        guard viewModel.tableViewItemsCount > 0, !searchBarIsHidden else { return }
        searchBarIsHidden = true
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

// MARK: settings button in navigation bar
private extension MainVC {

    @objc
    func openSettings() {
        guard let settingsVC = Storyboards.settins else {
            showText("Can't get \(Storyboards.Name.settings) storyboard")
            return
        }
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

extension MainVC : MainVCViewModelProtocol {

    func error(_ error: Error) {
        showText(error.localizedDescription)
    }

    func reloadTableView() {
        tableView.reloadData()
        hideSearchBar()
    }

    func show(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}
