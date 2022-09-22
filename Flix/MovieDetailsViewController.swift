//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by DeJa Barclay on 9/21/22.
//

import UIKit
import AlamofireImage
class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisView: UILabel!
    //@IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var movie = [String:Any]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //print(movie["title"])
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisView.text = movie["overview"] as? String
        synopsisView.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        posterView.af_setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        backdropView.af_setImage(withURL: backdropUrl!)
    }
    

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     print("loading up the details screen!!")
     Find the selected movie
     let cell = sender as! UITableViewCell
     let indexPath = tableView.indexPath(for: cell)!
     let movie = movies[indexPath.row]
     
      Pass the selected move to the details view controller
     let detailsViewController = segue.destination as! MovieDetailsViewController
     
     detailsViewController.movie =  movie

    }
    */

}
