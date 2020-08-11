//
//  ViewController.swift
//  MovieAppWithMoya
//
//  Created by iDev0 on 2020/07/26.
//  Copyright © 2020 Ju Young Jung. All rights reserved.
//

import UIKit
import Moya
import ProgressHUD



class ViewController: UIViewController {

    let movieProvider = MoyaProvider<MovieService>()
    var nowPlaying = [Movie]()
    var popular = [Movie]()
    var upcoming = [Movie]()
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ProgressHUD.show()
        
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
        
        ProgressHUD.dismiss()
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
        
        cell.delegate = self
        cell.sectionIndex = indexPath.section
        
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
        return 300
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        let collectionCell = cell.collectionView.indexPathsForSelectedItems
        print(collectionCell)
    }
}

extension ViewController: CustomCellDelegate {
    
    func didSelectCell(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, section: Int) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "DetailVC") as? DetailViewController
        
        switch section {
        case 0:
            detailVC?.movie = self.nowPlaying[indexPath.row]
        case 1:
            detailVC?.movie = self.upcoming[indexPath.row]
        case 2:
            detailVC?.movie = self.popular[indexPath.row]
        default:
            detailVC?.movie = nil
        }
                
        self.present(detailVC!, animated: true, completion: nil)
    }
    
}
