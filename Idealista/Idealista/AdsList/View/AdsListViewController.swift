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
    func fetchedAds(_ ads: [HomeAdListVO])
}

// Protocol: AdTableViewCell -> View
protocol AdTableViewCellProtocol: AnyObject {
    func navigateToMapLocation(latitude: CGFloat, longitude: CGFloat)
}


// MARK: - Class
class AdsListViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Vars
    var presenter: AdsListPresenterProtocol?
    private var homeAds: [HomeAdListVO] = []
    private let refreshControl: UIRefreshControl = UIRefreshControl()  // pull to refresh
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter else { return }
        presenter.viewDidLoad()
    }
    
    // Private functions
    private func setDelegatesTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func registerAdCell() {
        self.tableView.register(UINib(nibName: AdTableViewCell.name, bundle: nil), forCellReuseIdentifier: AdTableViewCell.name)
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

extension AdsListViewController: AdsListViewProtocol {
    
    func loadUI() {
        self.setDelegatesTableView()
        self.registerAdCell()
        self.addPullToRefresh()
    }
    
    func fetchedAds(_ ads: [HomeAdListVO]) {
        self.homeAds = ads
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.tableView.reloadData()
        }
    }
    
}

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

extension AdsListViewController: AdTableViewCellProtocol {
    
    func navigateToMapLocation(latitude: CGFloat, longitude: CGFloat) {
        if let navController = self.navigationController {
            guard let mapLocationView = MapLocationWireFrame.createMapLocationModule() as? MapLocationViewController else { return }
            mapLocationView.latitude = latitude
            mapLocationView.longitude = longitude
            navController.pushViewController(mapLocationView, animated: true)
        }
    }
    
}



