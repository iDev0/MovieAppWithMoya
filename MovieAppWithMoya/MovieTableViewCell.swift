//
//  MovieTableViewCell.swift
//  MovieAppWithMoya
//
//  Created by iDev0 on 2020/07/30.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    
    public var movies = [Movie]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var SectionNameLabel: UILabel!

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        // sdwebimage : objective-c
        // kingFisher : swift        
        if let imageName = movies[indexPath.row].posterPath {
            cell.poster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(imageName)"), placeholder: UIImage(systemName: "photo"))
        }
            
        cell.title.text = movies[indexPath.row].title        
        cell.ratingView.backgroundColor = .clear
        cell.ratingView.type = .floatRatings
        cell.ratingView.rating = movies[indexPath.row].voteAverage / 2
        return cell
        
    }
    
}
