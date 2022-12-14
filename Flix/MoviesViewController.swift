//
//  ViewController.swift
//  Flix
//
//  Created by DeJa Barclay on 9/16/22.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var movies = [[String:Any]]() // array of dictionaries
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // GET THE DATA FROM THE API
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // GET THE DATA FROM THE MOVIES DICTIONARY AND ONLY GET THE RESULTS KEY IN THE DATA
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.tableView.reloadData() // async kinda function to update state
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // the number of row to have in table view list
        return movies.count
    }
    
    // function called for every table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        // select row first move, second movie, etc
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        
        cell.titleLabel?.text = title
        cell.synopsisLable?.text = synopsis
        //cell.posterView.imageView.af.setImage(withURL: posterUrl)
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        
        return cell
    }
    
    //Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("loading up the details screen!!")
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        // Pass the selected move to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        detailsViewController.movie =  movie
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
        
        
    }
