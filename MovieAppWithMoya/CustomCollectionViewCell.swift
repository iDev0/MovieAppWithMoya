//
//  CustomCollectionViewCell.swift
//  MovieAppWithMoya
//
//  Created by iDev0 on 2020/07/31.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import UIKit
import FloatRatingView

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    
}
