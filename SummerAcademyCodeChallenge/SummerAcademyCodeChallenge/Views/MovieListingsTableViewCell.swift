//
//  MovieListingsTableViewCell.swift
//  SummerAcademyCodeChallenge
//
//  Created by Uchenna  Aguocha on 5/28/18.
//  Copyright © 2018 Uchenna  Aguocha. All rights reserved.
//

import UIKit

class MovieListingsTableViewCell: UITableViewCell {
    
    var movie: Entry? {
        didSet {
            
            movieTitleLabel.text = movie?.title
            releaseDateLabel.text = movie?.releaseDate
            priceLabel.text = movie?.price
            
            // Convert poster (image) urlString into UIImage
            guard let unwrappedImageString = movie?.poster else { return }
            guard let imageURLString = URL(string: unwrappedImageString) else { return }
            do {
                
                let movieEntryData = try Data(contentsOf: imageURLString)
                movieImageView.image = UIImage(data: movieEntryData)
            
            } catch let error {
                print("Failed to set image:", error)
            }
//            if let movieEntryData = Data(contentsOf: imageURLString) {
//               movieImageView.image = UIImage(data: movieEntryData)
//            }
            
            
        }
    }
    
    // MARK: UIComponents
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
//        view.layer.shadowRadius = 100
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 15)
        view.layer.shadowRadius = 8
        view.layer.shouldRasterize = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Release Date"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Price"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setupAutoLayout() {
        // Once this function is called, these ui components will be positioned with constraints
        
        contentView.addSubview(containerView)
        containerView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingBottom: 10, paddingRight: 16, width: 0, height: 170)
        
        // Add each ui component as a subview of container view
        [movieTitleLabel, releaseDateLabel, priceLabel, movieImageView].forEach { (view) in
            containerView.addSubview(view)
        }
        
        movieImageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 4, paddingBottom: 10, paddingRight: 0, width: 102, height: 142)
        
        movieTitleLabel.anchor(top: movieImageView.topAnchor, left: movieImageView.rightAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 22)
        
        releaseDateLabel.anchor(top: movieTitleLabel.bottomAnchor, left: movieImageView.rightAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 12, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 22)
        
        priceLabel.anchor(top: releaseDateLabel.bottomAnchor, left: movieImageView.rightAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 12, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 22)
        
    }
    
    
}





