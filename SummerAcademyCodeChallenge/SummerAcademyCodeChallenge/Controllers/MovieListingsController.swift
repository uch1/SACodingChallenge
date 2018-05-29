//
//  ViewController.swift
//  SummerAcademyCodeChallenge
//
//  Created by Uchenna  Aguocha on 5/26/18.
//  Copyright © 2018 Uchenna  Aguocha. All rights reserved.
//

import UIKit

class MovieListingsController: UITableViewController {
    
    let movieListingCellID = "movieListingCellID"
    
    
    var movies = [Entry](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "iTunes Preview"
        setupTableView()
        fetchingMovies()
    }
    
    func setupTableView() {
        tableView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        tableView.register(MovieListingsTableViewCell.self, forCellReuseIdentifier: movieListingCellID)
        tableView.separatorStyle = .none
    }
    
    func fetchingMovies() {
        
        Networking.shared.fetchMovies { (iTunesMovies) in
            dump(iTunesMovies)
            print("Executing Print Statement: \(iTunesMovies)")
            //            let iTunesMovies = try? JSONDecoder().decode(iTunes.self, from: data)
            //            print(iTunesMovies)
            //            guard let iTunesMovie = iTunesMovies?.feed.entry else { return }
            self.movies = iTunesMovies
            
        }
    }
    
}

extension MovieListingsController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieListingCellID, for: indexPath) as! MovieListingsTableViewCell
        let movie = movies[indexPath.row]
        
        cell.movie = movie
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        
        let movieDetailsController = MovieDetailsController()
        movieDetailsController.movie = movie
        
        navigationController?.pushViewController(movieDetailsController, animated: true)
    }
    
}













