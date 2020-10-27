//
//  WatchListVC.swift
//  iWatchList
//
//  Created by Brian Gomes on 22/10/2020.
//

import UIKit
import CoreData

class WatchListVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var watchItemArray = [WatchItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        setTableView()
    }

    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MainCells", bundle: nil), forCellReuseIdentifier: "mainCells")
    }
    
    func loadItems(){
            
        let request : NSFetchRequest<WatchItem> = WatchItem.fetchRequest()
            
            do{
                watchItemArray = try context.fetch(request)
            }catch{
                print("Error fetching data from context: ",error)
            }
            
           tableView.reloadData()
        }
        
    
    @IBAction func BackClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK:- TABLEVIEW

extension WatchListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCells", for: indexPath) as! MainCells
        cell.selectionStyle = .none
        cell.setWatchListData(data: watchItemArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("DELEte at\(indexPath.row)")
            
            context.delete(watchItemArray[indexPath.row])
            watchItemArray.remove(at: indexPath.row)
           // tableView.deleteRows(at: [indexPath.row], with: .fade)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do{
            try context.save()
                print("DATA SAVED")
            }
            catch{
                print("ERROR:",error.localizedDescription)
            }
  
        }
    }    
}
