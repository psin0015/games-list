//
//  ViewController.swift
//  Games List
//
//  Created by Prashant Singh on 23/1/22.
//

import UIKit

class GamesViewController: UIViewController {

    @IBOutlet weak var gamesTableView: UITableView!
    let activityView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI(){
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = appThemeColor
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        gamesTableView.dataSource = self
        gamesTableView.delegate = self
        gamesTableView.allowsSelection = false
        gamesTableView.register(UINib.init(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: gamesTableViewCellIdentifier)
        navigationItem.title = "Games List"
        
        //Setup the loading activity indicator
        activityView.hidesWhenStopped = true
        activityView.frame = CGRect(x: view.frame.midX - 25, y: view.frame.midY - 25, width: 50, height: 50)
        activityView.accessibilityIdentifier = "loadingSpinner"
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
        //Disable the user interaction until the games have been downloaded.
        gamesTableView.isUserInteractionEnabled = false
        
        GamesViewModel.shared.fetchGamesDelegate = self
        GamesViewModel.shared.fetchGames()
    }
}

extension GamesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GamesViewModel.shared.gamesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gamesCell = tableView.dequeueReusableCell(withIdentifier: gamesTableViewCellIdentifier, for: indexPath) as! GameTableViewCell
        gamesCell.gameTitle.text = GamesViewModel.shared.gamesList[indexPath.row].gameTitle
        
        GamesViewModel.shared.setImageFromUrl(imageURL: GamesViewModel.shared.gamesList[indexPath.row].imageURL){ (gameImage) in
            if let updateGameCell = tableView.cellForRow(at: indexPath) as? GameTableViewCell {
                updateGameCell.gameImageView.image = gameImage
            }
        }
        return gamesCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }        
}

extension GamesViewController: FetchGamesDelegate {
    
    func didDownloadGames() {
        DispatchQueue.main.async {
            self.gamesTableView.reloadData()
            self.gamesTableView.isUserInteractionEnabled = true
            self.activityView.stopAnimating()
        }
    }
}
