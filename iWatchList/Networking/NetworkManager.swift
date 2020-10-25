//
//  NetworkManager.swift
//  iWatchList
//
//  Created by Brian Gomes on 23/10/2020.
//

import Foundation
import Alamofire
import SwiftyJSON


//MARK:- POPULAR MOVIES SCRIPT

class PopularMoviesScript:NSObject{

static let shared = PopularMoviesScript()

var mainObj: MainVC!
var mainDataArr:[MainDataModel]=[]
    
    func callPopularMoviesScript(){
        
        AF.request(POPULAR_MOVIES_URL, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in

                    switch response.result {

                    case .success(let json):
                        print("POPULAR_MOVIES_RESPONSE:::",json)
                        let response = JSON(json)
                        DispatchQueue.main.async {
                            
                            self.initialise(resp: response, completion: { (data) in

                                self.mainObj.mainDataArr.removeAll()
                                print("APPEND_DATA_COUNT",self.mainObj.mainDataArr.count)
                                self.mainObj.mainDataArr = data
                                self.mainObj.tableView.reloadData()

                            })
                       }
                    case .failure(let error):
                        print(error)
                        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                      
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("Fetch again")
                           
                        }))
                        self.mainObj.present(alert, animated: true)
                        
                        break
                    }
            }

    }
    
    func initialise(resp: JSON,completion: @escaping (_ data: [MainDataModel]) -> ()){
        mainDataArr.removeAll()
        for i in resp["results"].arrayValue{
            
            let popularity = i["popularity"].doubleValue
            let voteCount = i["vote_count"].intValue
            let posterPath = i["poster_path"].stringValue
            let id = i["id"].intValue
            let adult = i["adult"].boolValue
            let backdropPath = i["backdrop_path"].stringValue
            let originalTitle = i["original_title"].stringValue
            let title = i["title"].stringValue
            let voteAverage = i["vote_average"].doubleValue
            let overview = i["overview"].stringValue
            let releaseDate = i["release_date"].stringValue
            
            print("Vote Average::",voteAverage)
            print("posterPath:;;",posterPath)
            print("releaseDAy",releaseDate)
            
            let fetchedData = MainDataModel(popularity: popularity, voteCount: voteCount, posterPath: posterPath, id: id, adult: adult, backdropPath: backdropPath, originalTitle: originalTitle, title: title, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate)

        self.mainDataArr.append(fetchedData)
        print("DataCount:",self.mainDataArr.count)
}
completion(mainDataArr)
        
    }
}

//MARK:- POPULAR TV SERIES SCRIPT

class PopularTVSeriesScript:NSObject{

static let shared = PopularTVSeriesScript()

var mainObj: MainVC!
var mainDataArr:[MainDataModel]=[]
    
    func callPopularTVSeriesScript(){
        
        AF.request(POPULAR_TVSERIES_URL, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in

                    switch response.result {

                    case .success(let json):
                        print("POPULAR_TVSERIES_RESPONSE:::",json)
                        let response = JSON(json)
                        DispatchQueue.main.async {
                            
                            self.initialise(resp: response, completion: { (data) in

                                self.mainObj.mainDataArr.removeAll()
                                print("APPEND_DATA_COUNT",self.mainObj.mainDataArr.count)
                                self.mainObj.mainDataArr = data
                                self.mainObj.tableView.reloadData()

                            })
                       }
                    case .failure(let error):
                        print(error)
                        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                      
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("Fetch again")
                           
                        }))
                        self.mainObj.present(alert, animated: true)
                        
                        break
                    }
            }

    }
    
    func initialise(resp: JSON,completion: @escaping (_ data: [MainDataModel]) -> ()){

        mainDataArr.removeAll()
        for i in resp["results"].arrayValue{
            
            let popularity = i["popularity"].doubleValue
            let voteCount = i["vote_count"].intValue
            let posterPath = i["poster_path"].stringValue
            let id = i["id"].intValue
            let adult = i["adult"].boolValue
            let backdropPath = i["backdrop_path"].stringValue
            let originalTitle = i["original_title"].stringValue
            let title = i["name"].stringValue
            let voteAverage = i["vote_average"].doubleValue
            let overview = i["overview"].stringValue
            let releaseDate = i["first_air_date"].stringValue
            
            print("Vote Average::",voteAverage)
            print("posterPath:;;",posterPath)
            print("releaseDAy",releaseDate)
            
            let fetchedData = MainDataModel(popularity: popularity, voteCount: voteCount, posterPath: posterPath, id: id, adult: adult, backdropPath: backdropPath, originalTitle: originalTitle, title: title, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate)

        self.mainDataArr.append(fetchedData)
        print("DataCount:",self.mainDataArr.count)
}
completion(mainDataArr)
        
    }
}

//MARK:- SEARCH MOVIES SCRIPT

class SearchMoviesScript:NSObject{

static let shared = SearchMoviesScript()

var mainObj: MainVC!
var mainDataArr:[MainDataModel]=[]
    
    func callSearchMoviesScript(query:String){
        let trimmedQuery = query.replacingOccurrences(of: " ", with: "%20")
        print("TRIMMED_URL =",SEARCH_TVSERIES_URL+trimmedQuery)
        AF.request(SEARCH_MOVIES_URL+trimmedQuery, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in

                    switch response.result {

                    case .success(let json):
                        print("SEARCH_MOVIES_RESPONSE:::",json)
                        let response = JSON(json)
                        DispatchQueue.main.async {
                            
                            self.initialise(resp: response, completion: { (data) in

                                self.mainObj.mainDataArr.removeAll()
                                print("APPEND_DATA_COUNT",self.mainObj.mainDataArr.count)
                                self.mainObj.mainDataArr = data
                                self.mainObj.tableView.reloadData()

                            })
                       }
                    case .failure(let error):
                        print(error)
                        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                      
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("Fetch again")
                           
                        }))
                        self.mainObj.present(alert, animated: true)
                        
                        break
                    }
            }

    }
    
    func initialise(resp: JSON,completion: @escaping (_ data: [MainDataModel]) -> ()){

        mainDataArr.removeAll()
        
        for i in resp["results"].arrayValue{
            
            let popularity = i["popularity"].doubleValue
            let voteCount = i["vote_count"].intValue
            let posterPath = i["poster_path"].stringValue
            let id = i["id"].intValue
            let adult = i["adult"].boolValue
            let backdropPath = i["backdrop_path"].stringValue
            let originalTitle = i["original_title"].stringValue
            let title = i["title"].stringValue
            let voteAverage = i["vote_average"].doubleValue
            let overview = i["overview"].stringValue
            let releaseDate = i["release_date"].stringValue
            
            print("Vote Average::",voteAverage)
            print("posterPath:;;",posterPath)
            print("releaseDAy",releaseDate)
            
            let fetchedData = MainDataModel(popularity: popularity, voteCount: voteCount, posterPath: posterPath, id: id, adult: adult, backdropPath: backdropPath, originalTitle: originalTitle, title: title, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate)

            print("POSTER_PATH:::",posterPath)
            if posterPath != ""{
        self.mainDataArr.append(fetchedData)
            }
            
        print("DataCount:",self.mainDataArr.count)
}
completion(mainDataArr)
        
    }
}




//MARK:- SEARCH TV-SERIES SCRIPT

class SearchTVSeriesScript:NSObject{

static let shared = SearchTVSeriesScript()

var mainObj: MainVC!
var mainDataArr:[MainDataModel]=[]
    
    func callSearchTVSeriesScript(query:String){
        let trimmedQuery = query.replacingOccurrences(of: " ", with: "%20")
        print("TRIMMED_URL =",SEARCH_TVSERIES_URL+trimmedQuery)
        AF.request(SEARCH_TVSERIES_URL+trimmedQuery, method: .get, encoding: JSONEncoding.default)
                .responseJSON { response in

                    switch response.result {

                    case .success(let json):
                        print("SEARCH_TVSERIES_RESPONSE:::",json)
                        let response = JSON(json)
                        DispatchQueue.main.async {
                            
                            self.initialise(resp: response, completion: { (data) in

                                self.mainObj.mainDataArr.removeAll()
                                print("APPEND_DATA_COUNT",self.mainObj.mainDataArr.count)
                                self.mainObj.mainDataArr = data
                                self.mainObj.tableView.reloadData()

                            })
                       }
                    case .failure(let error):
                        print(error)
                        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                      
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            print("Fetch again")
                           
                        }))
                        self.mainObj.present(alert, animated: true)
                        
                        break
                    }
            }

    }
    
    func initialise(resp: JSON,completion: @escaping (_ data: [MainDataModel]) -> ()){

        mainDataArr.removeAll()
        
        for i in resp["results"].arrayValue{
            
            let popularity = i["popularity"].doubleValue
            let voteCount = i["vote_count"].intValue
            let posterPath = i["poster_path"].stringValue
            let id = i["id"].intValue
            let adult = i["adult"].boolValue
            let backdropPath = i["backdrop_path"].stringValue
            let originalTitle = i["original_title"].stringValue
            let title = i["name"].stringValue
            let voteAverage = i["vote_average"].doubleValue
            let overview = i["overview"].stringValue
            let releaseDate = i["first_air_date"].stringValue
            
            print("Vote Average::",voteAverage)
            print("posterPath:;;",posterPath)
            print("releaseDAy",releaseDate)
            
            
            
            let fetchedData = MainDataModel(popularity: popularity, voteCount: voteCount, posterPath: posterPath, id: id, adult: adult, backdropPath: backdropPath, originalTitle: originalTitle, title: title, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate)

            print("POSTER_PATH:::",posterPath)
            if posterPath != ""{
        self.mainDataArr.append(fetchedData)
            }
        print("DataCount:",self.mainDataArr.count)
}
completion(mainDataArr)
        
    }
}
