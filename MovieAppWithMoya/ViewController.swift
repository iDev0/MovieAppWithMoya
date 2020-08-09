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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.movies = self.nowPlaying
        case 1:
            cell.movies = self.upcoming
        case 2:
            cell.movies = self.popular
        default:
            cell.movies = [Movie]()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Now Playing"
        case 1:
            return "UpComing"
        case 2:
            return "Popular"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
    
    
}
