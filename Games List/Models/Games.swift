//
//  Games.swift
//  Games List
//
//  Created by Prashant Singh on 23/1/22.
//

import UIKit

class Games: NSObject {

    var gameTitle: String
    var imageURL: String
    
    init(gameTitle: String, imageURL: String) {
        self.gameTitle = gameTitle
        self.imageURL = imageURL
    }
}
