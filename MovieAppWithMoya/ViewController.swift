//
//  ViewController.swift
//  MovieAppWithMoya
//
//  Created by iDev0 on 2020/07/26.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    let movieProvider = MoyaProvider<MovieService>()
    var nowPlaying = [Movie]()
    var popular = [Movie]()
    var upcoming = [Movie]()
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getData(.nowPlaying) { (movies) in
            OperationQueue.main.addOperation {
                self.nowPlaying = movies
                self.movieTableView.reloadData()
            }
        }
        
        getData(.popular) { (movies) in
            OperationQueue.main.addOperation {
                self.popular = movies
                self.movieTableView.reloadData()
            }
        }
        
        getData(.upcoming) { (movies) in
            OperationQueue.main.addOperation {
                self.upcoming = movies
                self.movieTableView.reloadData()
            }
        }
    }
    
    
    func getData(_ target: MovieService, completion : @escaping ([Movie]) -> Void) {
        movieProvider.request(target) { (result) in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let dataStore = try! decoder.decode(MovieDataStore.self, from: response.data)
                completion(dataStore.results)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.SectionNameLabel.text = "Now Playing"
            cell.movies = self.nowPlaying
            cell.collectionView.reloadData()
            break
        case 1:
            cell.SectionNameLabel.text = "Up Coming"
            cell.movies = self.upcoming
            cell.collectionView.reloadData()
            break
        case 2:
            cell.SectionNameLabel.text = "Popular"
            cell.movies = self.popular
            cell.collectionView.reloadData()
            break
        default:
            cell.SectionNameLabel.text = ""
            cell.movies = [Movie]()
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
