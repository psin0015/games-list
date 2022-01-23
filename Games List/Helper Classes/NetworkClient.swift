//
//  NetworkClient.swift
//  Games List
//
//  Created by Prashant Singh on 23/1/22.
//

import UIKit

class NetworkClient: NSObject {
    
    static let shared = NetworkClient()
    private override init() {}
    
    func fetchGamesFromURL(urlString: String, completion: @escaping (Result<Data, Error>) -> Void){
        
        //Create url instance using url string
        guard let url = URL(string: urlString)
            else
        {
            return
        }
        
        //Create task object using url session
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Initialise dataresponse if there is data received using the url
            if let dataResponse = data{
                completion(.success(dataResponse))
            }else{
                completion(.failure(error!))
            }
        }
        // Start the data task
        task.resume()
    }
    
    func fetchImageFromURL(imageURL: String, completion: @escaping (Result<Data, Error>) -> Void){
                
        URLSession.shared.dataTask( with: NSURL(string:imageURL)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    completion(.success(data))
                }else{
                    completion(.failure(error!))
                }
            }
        }).resume()
    }
}
