//
//  TableControllerSubscribe.swift
//  Watch Watchlist
//
//  Created by Johan Teekens on 27/09/2016.
//  Copyright © 2016 Steltix. All rights reserved.
//


import UIKit

class TableControllerDashboard: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // var Watchlists: [Globals.Watchlist] = []
    
    @IBOutlet var lastUpdateLBL: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    func keepUpdating(){
        
        
        print("just refresh table")
        Globals.updateDashboardWatchlists()
        self.tableView.reloadData()
        self.lastUpdateLBL.text=Globals.sharedGlobal.lastUpdated
        
        DispatchQueue.global(qos: .background).async {
            print("Start update on background thread")
            Globals.updateWatchlists()
            
            self.tableView.reloadData()
            self.lastUpdateLBL.text=Globals.sharedGlobal.lastUpdated
            print("End update on background thread")
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Globals.loadWatchlists()
        Globals.updateDashboardWatchlists()
        self.lastUpdateLBL.text=Globals.sharedGlobal.lastUpdated
        //Globals.getDashboardWatchlistsFromSettings()
        //Globals.sharedManager.sharedWatchlists=Globals.getDashboardWatchlistsFromSettings()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        //keep refreshing
        
        _ = Timer.scheduledTimer(
            timeInterval: 30.0, target: self, selector: #selector(keepUpdating),
            userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
       Globals.updateDashboardWatchlists()
        print("refresh")
        self.tableView.reloadData()
        self.lastUpdateLBL.text=Globals.sharedGlobal.lastUpdated
        
    }
    
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("refresh")
        //Globals.getDashboardWatchlistsFromSettings()
        self.tableView.reloadData()
        self.lastUpdateLBL.text=Globals.sharedGlobal.lastUpdated
        refreshControl.endRefreshing()
        
        
    }
    
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Globals.getDashboardWatchlistsFromSettings()
        return Globals.sharedGlobal.dashboardWatchLists.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDashboard") as! CellDashboard
        cell.NameLBL.text = Globals.sharedGlobal.dashboardWatchLists[indexPath.row].name
        cell.StatusBTN.layer.cornerRadius = 20
        cell.StatusBTN.layer.borderWidth = 1
        cell.accessoryType = .none
        //print ("Adding to grid: " + Globals.sharedGlobal.dashboardWatchLists[indexPath.row].name )
        //print ("Rowcount: " + String(Globals.sharedGlobal.dashboardWatchLists[indexPath.row].recordCount))
        //print ("Critical: " + String(Globals.sharedGlobal.dashboardWatchLists[indexPath.row].criticalThreshold))
        //print ("Warning: " + String(Globals.sharedGlobal.dashboardWatchLists[indexPath.row].criticalThreshold))
        if (Globals.sharedGlobal.dashboardWatchLists[indexPath.row].recordCount == -1)
        {
            cell.StatusBTN.backgroundColor=UIColor.white
            cell.StatusBTN.setTitle("", for: UIControlState.normal)
        }
        else
        {
            cell.StatusBTN.setTitle(String(Globals.sharedGlobal.dashboardWatchLists[indexPath.row].recordCount), for: UIControlState.normal)
            cell.StatusBTN.backgroundColor=UIColor.green
            if (Globals.sharedGlobal.dashboardWatchLists[indexPath.row].criticalThreshold>0)
            {
                if ( Globals.sharedGlobal.dashboardWatchLists[indexPath.row].recordCount >= Globals.sharedGlobal.dashboardWatchLists[indexPath.row].criticalThreshold)
                {cell.StatusBTN.backgroundColor=UIColor.red}
                else
                {
                    if ( Globals.sharedGlobal.dashboardWatchLists[indexPath.row].recordCount >= Globals.sharedGlobal.dashboardWatchLists[indexPath.row].warningThreshold)
                    {cell.StatusBTN.backgroundColor=UIColor.orange}
                }
            }
        }   
        return cell
    }
    
    
    
    
    
    
}
