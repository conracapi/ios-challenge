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


// MARK: - Class
class AdsListViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Vars
    private var homeAds: [HomeAdListVO] = []
    var presenter: AdsListPresenterProtocol?

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
}

extension AdsListViewController: AdsListViewProtocol {
    
    func loadUI() {
        self.setDelegatesTableView()
        self.registerAdCell()
    }
    
    func fetchedAds(_ ads: [HomeAdListVO]) {
        self.homeAds = ads
        DispatchQueue.main.async {
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
        adCell.load(homeAd: self.homeAds[indexPath.row])
        return adCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hay que navegar al detalle del anuncio \(indexPath.row)")
    }
    
}



