//
//  MovieDetailsControllers.swift
//  SummerAcademyCodeChallenge
//
//  Created by Uchenna  Aguocha on 5/28/18.
//  Copyright © 2018 Uchenna  Aguocha. All rights reserved.
//

import UIKit

class MovieDetailsController: UIViewController {
    
    // MARK: Properties
    var movie: Entry? {
        didSet {
            movieTitleLabel.text = movie?.title
            releaseDateLabel.text = movie?.releaseDate
            priceLabel.text = movie?.price
            summaryTextView.text = movie?.summary
            
            // Convert poster (image) urlString into UIImage
            guard let unwrappedImageString = movie?.poster else { return }
            guard let imageURLString = URL(string: unwrappedImageString) else { return }
            do {
                let movieEntryData = try Data(contentsOf: imageURLString)
                movieImageView.image = UIImage(data: movieEntryData)
                
            } catch let error {
                print("Failed to set image:", error)
            }
        }
    }
    
    // MARK: UIComponents
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.gray
        return imageView
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Title"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.bold)
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customPink
        label.text = "Release Date"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customPink
        label.text = "Price"
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        return label
    }()
    
    let summaryTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
//        textView.layer.borderColor = UIColor.customPink.cgColor
//        textView.layer.borderWidth = 1
//        textView.layer.cornerRadius = 5
        textView.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        return textView
    }()
    
    let iTunesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.customPink
        button.layer.cornerRadius = 20
        button.setTitle("Open iTunes", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.addTarget(self, action: #selector(openiTunes), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Top Movies"
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        
        [movieImageView, releaseDateLabel, priceLabel, summaryTextView, iTunesButton].forEach { (uiview) in
            view.addSubview(uiview)
        }
        
        movieImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 290)
        
        movieImageView.insertSubview(movieTitleLabel, aboveSubview: movieImageView)
        movieTitleLabel.anchor(top: nil, left: movieImageView.leftAnchor, bottom: movieImageView.bottomAnchor, right: movieImageView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 50)
        
        releaseDateLabel.anchor(top: movieImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 160, height: 22)
        
        priceLabel.anchor(top: movieImageView.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 22)
        
        summaryTextView.anchor(top: releaseDateLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 200)
        summaryTextView.centerAnchor(centerX: view.centerXAnchor, centerY: nil)
        
        
        iTunesButton.anchor(top: summaryTextView.bottomAnchor, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 120, height: 40)
        
        
    }
    
    @objc func openiTunes() {
        // Open iTunes
        print("Open iTUNES")
        print("Printing movie link: \(movie?.link)")
        
        if let movieURL = URL(string: (movie?.link)!) {
            UIApplication.shared.open(movieURL, options: [:], completionHandler: nil)
        } else {
            print("Failed to open iTunes...")
        }
        
    }
    
    
}


