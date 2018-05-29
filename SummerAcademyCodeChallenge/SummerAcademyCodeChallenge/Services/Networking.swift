//
//  Networking.swift
//  SummerAcademyCodeChallenge
//
//  Created by Uchenna  Aguocha on 5/26/18.
//  Copyright © 2018 Uchenna  Aguocha. All rights reserved.
//

import Foundation
import UIKit

class Networking {
    static let shared = Networking()
    
    let sharedSession = URLSession.shared
    let baseURL = URL(string: "https://itunes.apple.com/us/rss/topmovies/limit=25/json")
    
    func fetchMovies(completionHandler: @escaping ([Entry]) -> Void) {
        
        var request = URLRequest(url: baseURL!)
        request.httpMethod = "GET"
        
        let task = sharedSession.dataTask(with: request) { (data, response, error) in
            
            
            if let data = data {
                 let iTunesMovies = try? JSONDecoder().decode(iTunes.self, from: data)
                completionHandler((iTunesMovies?.feed.entry)!)
            }
            else {
                print(error?.localizedDescription ?? "Error")
            }
            
            
            
//            do {
//                //Decode retrived data with JSONDecoder and assing type of Station object
//                let iTunesMovies = try JSONDecoder().decode(iTunesMovie.self, from: data!)
//
//                //Get back to the main queue
//                DispatchQueue.main.async {
//                    completionHandler(iTunesMovies.feed.entry)
//                    dump(iTunesMovies.feed.entry)
//
//                }
//            } catch (let error) {
//                print(error)
//                print(error.localizedDescription)
//            }
            
    
        }
        task.resume()
    }
    
    
}

