//
//  GameTableViewCell.swift
//  Games List
//
//  Created by Prashant Singh on 23/1/22.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        gameImageView.image = UIImage()
    }    
}
