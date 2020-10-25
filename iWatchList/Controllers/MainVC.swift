//
//  MainVC.swift
//  iWatchList
//
//  Created by Brian Gomes on 22/10/2020.
//

import UIKit

class MainVC: UIViewController {

    var mainDataArr:[MainDataModel]=[]
    
    @IBOutlet weak var tvSeriesBtn: UIButton!
    @IBOutlet weak var moviesBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isMoviesSelected = true
    
    override func viewDidLoad() {
        super.viewDidLoad()


        setUpSearchBar()
        loadMovies()
        setTableView()
        setButtons()
        
       
    }
    
  
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MainCells", bundle: nil), forCellReuseIdentifier: "mainCells")
    }
    
    func loadMovies(){
        
        //Network call to fetch movies when the app is first started
        mainDataArr.removeAll()
        print("DATA COUNT",mainDataArr.count)
        PopularMoviesScript.shared.mainObj = self
        PopularMoviesScript.shared.callPopularMoviesScript()
        
    }

    func loadTVSeries(){
        PopularTVSeriesScript.shared.mainObj = self
        PopularTVSeriesScript.shared.callPopularTVSeriesScript()
       
    }
    
    func setUpSearchBar(){
        searchBar.delegate = self as UISearchBarDelegate
      
        searchBar.placeholder = "Search Movies"
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            
        }
    }
    
    func setButtons(){
        moviesBtn.backgroundColor = UIColor.systemGreen
        moviesBtn.tintColor = UIColor.white
        moviesBtn.isUserInteractionEnabled = false
    }
    

    @IBAction func MoviesClicked(_ sender: Any) {
        
//        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
//        let watchList = storyBoard.instantiateViewController(withIdentifier: "watchListVC") as! WatchListVC
//        watchList.modalPresentationStyle = .fullScreen
//        self.present(watchList, animated: true, completion: nil)
        
        isMoviesSelected = true
        loadMovies()
        searchBar.placeholder = "Search Movies"
        tvSeriesBtn.backgroundColor = UIColor.white
        tvSeriesBtn.tintColor = UIColor.darkGray
       // moviesBtn.isUserInteractionEnabled = true
        
        moviesBtn.backgroundColor = UIColor.systemGreen
        moviesBtn.tintColor = UIColor.white
        
    }
    
    @IBAction func tvSeriesClicked(_ sender: Any) {
   

        mainDataArr.removeAll()
        print("DATA COUNT",mainDataArr.count)
        isMoviesSelected = false
        loadTVSeries()
        
        searchBar.placeholder = "Search TV-Series"
        moviesBtn.backgroundColor = UIColor.white
        moviesBtn.tintColor = UIColor.darkGray
        moviesBtn.isUserInteractionEnabled = true
        
        tvSeriesBtn.backgroundColor = UIColor.systemGreen
        tvSeriesBtn.tintColor = UIColor.white
        
        
        
    }
    @IBAction func heartClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let watchList = storyBoard.instantiateViewController(withIdentifier: "watchListVC") as! WatchListVC
        watchList.modalPresentationStyle = .fullScreen
        self.present(watchList, animated: true, completion: nil)
        
    }
    
}

//MARK:- TABLEVIEW

extension MainVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCells", for: indexPath) as! MainCells
        cell.selectionStyle = .none
        cell.setData(data: mainDataArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let detail = storyBoard.instantiateViewController(withIdentifier: "detailVC") as! DetailVC
        detail.modalPresentationStyle = .fullScreen
        detail.originalTitle = mainDataArr[indexPath.row].title
        detail.releaseDate = mainDataArr[indexPath.row].releaseDate
        detail.imgUrl = mainDataArr[indexPath.row].posterPath
        detail.imdb = mainDataArr[indexPath.row].voteAverage
        detail.voteCount = mainDataArr[indexPath.row].voteCount
        detail.overView = mainDataArr[indexPath.row].overview
        detail.popularity = mainDataArr[indexPath.row].popularity
        self.present(detail, animated: true, completion: nil)
    }
    
    
}

//MARK:- SEARCHBAR FUNCTIONS

extension MainVC: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        view.endEditing(true)
    
        if searchBar.text == ""{
            print("SearchBar Empty")
            searchBar.placeholder = "Type a movie title."
        }
        else if isMoviesSelected{
            mainDataArr.removeAll()
            print("DATA COUNT::",mainDataArr.count)
            SearchMoviesScript.shared.mainObj = self
            SearchMoviesScript.shared.callSearchMoviesScript(query: searchBar.text!)
        }else{
            mainDataArr.removeAll()
            print("DATA COUNT::",mainDataArr.count)
            SearchTVSeriesScript.shared.mainObj = self
            SearchTVSeriesScript.shared.callSearchTVSeriesScript(query: searchBar.text!)
        }
        
    }
    
    
}


