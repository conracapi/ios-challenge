//
//  AdsListView.swift
//  Idealista
//
//  Created by Conrado Capilla García on 22/11/24.
//  
//

import UIKit


// MARK: - Protocols
// Protocol: Presenter -> View
protocol AdsListViewProtocol: AnyObject {
    var presenter: AdsListPresenterProtocol? { get set }
    func loadUI()
    func fetchedAds(_ ads: [HomeAdListViewModel])
    func hideBackButtonNavBar()
}

// Protocol: AdTableViewCell -> View
protocol AdTableViewCellProtocol: AnyObject {
    func showAdLocationOnMap(latitude: CGFloat, longitude: CGFloat)
    func saveFavoriteAd(_ ad: HomeAdListViewModel)
}


// MARK: - Class
final class AdsListViewController: BaseViewController {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Vars
    var presenter: AdsListPresenterProtocol?
    private var homeAds: [HomeAdListViewModel] = []
    private let refreshControl: UIRefreshControl = UIRefreshControl()  // pull to refresh
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter else { return }
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let presenter else { return }
        presenter.viewWillAppear()
    }
    
    // Private functions
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: AdTableViewCell.name, bundle: nil), forCellReuseIdentifier: AdTableViewCell.name)
    }
    
    private func setStyles() {
        self.view.backgroundColor = .mainBackground
        self.tableView.backgroundColor = .mainBackground
        self.tableView.showsVerticalScrollIndicator = false
    }
    
    private func addPullToRefresh() {
        self.refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl)
    }
    
    @objc func refreshData() {
        guard let presenter = self.presenter else { return }
        presenter.fetchAllAds()
    }
}


// Protocols: set tableView
extension AdsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeAds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.name, for: indexPath)
        guard let adCell = cell as? AdTableViewCell else { return UITableViewCell() }
        adCell.delegate = self
        adCell.load(homeAd: self.homeAds[indexPath.row])
        return adCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let adDetailViewController = AdDetailWireFrame.createAdDetailModule()
        self.navigationController?.pushViewController(adDetailViewController, animated: true)
    }
}


// Protocol: Presenter -> View
extension AdsListViewController: AdsListViewProtocol {
    
    func loadUI() {
        self.configureTableView()
        self.setStyles()
        self.addPullToRefresh()
    }
    
    func fetchedAds(_ ads: [HomeAdListViewModel]) {
        self.homeAds = ads
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.tableView.reloadData()
        }
    }
    
    func hideBackButtonNavBar() {
        self.navigationItem.leftBarButtonItem = nil
    }
}


// Protocol: AdTableViewCell -> View
extension AdsListViewController: AdTableViewCellProtocol {
    
    func showAdLocationOnMap(latitude: CGFloat, longitude: CGFloat) {
        guard let presenter else { return }
        presenter.showAdLocationOnMap(latitude: latitude, longitude: longitude)
    }
    
    func saveFavoriteAd(_ ad: HomeAdListViewModel) {
        guard let presenter else { return }
        presenter.saveFavoriteAd(ad)
    }
}
