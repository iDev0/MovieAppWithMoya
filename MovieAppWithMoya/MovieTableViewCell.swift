//
//  MovieTableViewCell.swift
//  MovieAppWithMoya
//
//  Created by iDev0 on 2020/07/30.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    public var movies = [Movie]()
    
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
        
        
        if let imageName = movies[indexPath.row].posterPath {
            let image = URL(string: "https://image.tmdb.org/t/p/w500/\(imageName)")
            let imageData = try! Data(contentsOf: image!)
            cell.poster.image = UIImage(data: imageData)
        } else {
            cell.poster.image = UIImage(systemName: "photo")
        }
                
        cell.title.text = movies[indexPath.row].title
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
    
    
}
