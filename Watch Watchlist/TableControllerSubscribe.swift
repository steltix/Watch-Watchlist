//
//  TableControllerSubscribe.swift
//  Watch Watchlist
//
//  Created by Johan Teekens on 27/09/2016.
//  Copyright © 2016 Steltix. All rights reserved.
//


import UIKit

class TableControllerSubscribe: UIViewController, UITableViewDelegate, UITableViewDataSource {
var refreshControl = UIRefreshControl()
    
    
    
//var refreshControl: UIRefreshControl!
var Watchlists: [Globals.Watchlist] = []
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Watchlists=Globals.getWatchlistsFromSettings()
      
        
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("refresh")
        Globals.updateWatchlistsInSettings()
        Watchlists=Globals.getWatchlistsFromSettings()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Watchlists.count
    }
    
   
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     //   tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellSubscribe
        cell.NameCell.text = Watchlists[indexPath.row].name
        cell.DescriptionCell.text = Watchlists[indexPath.row].description
        cell.TypeCell.text = Watchlists[indexPath.row].type
        
        cell.DashboardBTN.tag = indexPath.row
        cell.DashboardBTN.addTarget(self, action: #selector(selectionButtonClicked), for: UIControlEvents.touchUpInside)
        cell.DashboardBTN.setTitle("", for: UIControlState.normal)
        if(!Watchlists[indexPath.row].dashboard){
           
            
            cell.DashboardBTN.backgroundColor = UIColor.white
            cell.DashboardBTN.layer.borderColor = UIColor.darkGray.cgColor
            cell.DashboardBTN.layer.borderWidth = 1
            cell.DashboardBTN.layer.cornerRadius = 5.0
            
        }else{
            cell.DashboardBTN.backgroundColor = UIColor.green
            cell.DashboardBTN.layer.borderColor = UIColor.darkGray.cgColor
            cell.DashboardBTN.layer.borderWidth = 1
            cell.DashboardBTN.layer.cornerRadius = 5.0
            
        }
        
        
        cell.accessoryType = .detailDisclosureButton
       
        
        return cell
    }
    
    func selectionButtonClicked(sender: UIButton){
        let buttonTag = sender.tag
        print ("Button click: " + String(buttonTag))
        if (sender.backgroundColor==UIColor.green)
        {
            sender.backgroundColor=UIColor.white
            Watchlists[buttonTag].dashboard=false
        }
        else
        {
            sender.backgroundColor=UIColor.green
            Watchlists[buttonTag].dashboard=true

        }
     
        Globals.setWatchlistsInSettings(Watchlists: Watchlists)
    }
    
    
    
   
}
