//
//  MainVC.swift
//  iWatchList
//
//  Created by Brian Gomes on 22/10/2020.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()



        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
        }
        
       
    }
    

    @IBAction func MoviesClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let watchList = storyBoard.instantiateViewController(withIdentifier: "watchListVC") as! WatchListVC
        watchList.modalPresentationStyle = .fullScreen
        self.present(watchList, animated: true, completion: nil)
        
    }
    
    @IBAction func tvSeriesClicked(_ sender: Any) {
   
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let detail = storyBoard.instantiateViewController(withIdentifier: "detailVC") as! DetailVC
        detail.modalPresentationStyle = .fullScreen
        self.present(detail, animated: true, completion: nil)
        
        
    }
    @IBAction func heartClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let watchList = storyBoard.instantiateViewController(withIdentifier: "watchListVC") as! WatchListVC
        self.present(watchList, animated: true, completion: nil)
        
    }
    
}



