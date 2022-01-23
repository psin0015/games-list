//
//  GamesViewModel.swift
//  Games List
//
//  Created by Prashant Singh on 23/1/22.
//

import UIKit

protocol FetchGamesDelegate {
    func didDownloadGames()
}

class GamesViewModel: NSObject {
    
    static let shared = GamesViewModel()
    private override init() {}
    
    var cache = NSCache<NSString, UIImage>()
    var gamesList : [Games] = []
    
    //Delegate for data binding
    var fetchGamesDelegate : FetchGamesDelegate?
    
    func fetchGames(){
        
        NetworkClient.shared.fetchGamesFromURL(urlString: gamesListURL){ [weak self] result in
            
            switch result{
            case .success(let data):
                self?.parseResponse(responseData: data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setImageFromUrl(imageURL :String, completion: @escaping (UIImage) -> ()) {
        if let gameImage = self.cache.object(forKey: imageURL as NSString) {
            DispatchQueue.main.async {
                completion(gameImage)
            }
        }else{
            if let placeholderImage = UIImage(named: "games"){
                DispatchQueue.main.async {
                    completion(placeholderImage)
                }
            }
            NetworkClient.shared.fetchImageFromURL(imageURL: imageURL){ [weak self] result in
                switch result{
                case .success(let data):
                    if let gameImage = UIImage(data: data){
                        self?.cache.setObject(gameImage, forKey: imageURL as NSString)
                        DispatchQueue.main.async {
                            completion(gameImage)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func parseResponse(responseData: Data){
        
        do{
            //Transform the data response into dictionary
            if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any],
               let gamesResultsDictionary = jsonResponse["games"] as? [String : Any]
            {
                for (_, gamesDictionaryValue) in gamesResultsDictionary{
                    
                    if let gameResult = gamesDictionaryValue as? [String : Any], let gameTitle = gameResult["gameName"] as? String, let gameImageURL = gameResult["imageUrl"] as? String {
                        gamesList.append(Games(gameTitle: gameTitle, imageURL: gameImageURL))
                    }else{
                        continue
                    }
                }
            }
            
        } catch let parsingError {
            print("Error", parsingError)
        }
        
        fetchGamesDelegate?.didDownloadGames()
    }
}
