//
//  DetailVC.swift
//  iWatchList
//
//  Created by Brian Gomes on 22/10/2020.
//

import UIKit
import Kingfisher
import CoreData

class DetailVC: UIViewController {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var imdbLbl: UILabel!
    @IBOutlet weak var voteCountLbl: UILabel!
    @IBOutlet weak var popularityLbl: UILabel!
    @IBOutlet weak var overViewLbl: UITextView!
    
    
    var imgUrl:String = ""
    var originalTitle:String = ""
    var releaseDate:String = ""
    var imdb:Double = 0.0
    var voteCount:Int = 0
    var popularity:Double = 0.0
    var overView:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Selected Title::",originalTitle)
        setData()
    }
    

    func setData(){
        
        let url = URL(string:"https://image.tmdb.org/t/p/w500"+imgUrl)
        posterImage.kf.setImage(with:url)
        titleLbl.text = originalTitle
        releaseLbl.text = releaseDate
        imdbLbl.text = String(imdb)
        voteCountLbl.text = String(voteCount)
        popularityLbl.text = String(popularity.rounded())
        overViewLbl.text = overView
    }
  
    @IBAction func BackClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func searchClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addClicked(_ sender: Any) {
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
        let newWatchItem = WatchItem(context: context)
        newWatchItem.posterPath = imgUrl
        newWatchItem.originalTitle = originalTitle
        newWatchItem.releaseDate = releaseDate
        newWatchItem.voteAverage = imdb
        newWatchItem.voteCount = Int32(voteCount)
        newWatchItem.popularity = popularity
        newWatchItem.overview = overView
        newWatchItem.title = originalTitle
        
        do{
        try context.save()
            print("DATA SAVED")
        }
        catch{
            print("ERROR:",error.localizedDescription)
        }
        
        let alert = UIAlertController(title: "Alert", message: originalTitle+" Added sucessfully to Watchlist", preferredStyle: .alert)
      
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            print("ok Tappdd")
           
        }))
        
        alert.addAction(UIAlertAction(title: "Watchlist", style: .default, handler: { action in
            let storyBoard = UIStoryboard(name: "Main", bundle:nil)
            let detail = storyBoard.instantiateViewController(withIdentifier: "watchListVC") as! WatchListVC
            detail.modalPresentationStyle = .fullScreen
            self.present(detail, animated: true, completion: nil)
           
        }))
       present(alert, animated: true)
        
    }

}
