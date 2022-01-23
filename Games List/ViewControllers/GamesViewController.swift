//
//  ViewController.swift
//  Games List
//
//  Created by Prashant Singh on 23/1/22.
//

import UIKit

class GamesViewController: UIViewController {

    @IBOutlet weak var gamesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI(){
        gamesTableView.dataSource = self
        gamesTableView.delegate = self
        gamesTableView.register(UINib.init(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: gamesTableViewCellIdentifier)
        navigationItem.title = "Games List"
    }
}
extension GamesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gamesCell = tableView.dequeueReusableCell(withIdentifier: gamesTableViewCellIdentifier, for: indexPath) as! GameTableViewCell
                                        
        return gamesCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }        
}

