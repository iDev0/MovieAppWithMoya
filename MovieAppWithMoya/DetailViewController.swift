//
//  DetailViewController.swift
//  MovieAppWithMoya
//
//  Created by iDev0 on 2020/08/09.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import UIKit
import FloatRatingView

class DetailViewController: UIViewController {

    public var movie: Movie?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let model = movie {
            titleLabel.text = model.title
            ratingView.rating = model.voteAverage / 2
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
