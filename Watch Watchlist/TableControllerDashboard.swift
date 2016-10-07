//
//  TableControllerSubscribe.swift
//  Watch Watchlist
//
//  Created by Johan Teekens on 27/09/2016.
//  Copyright © 2016 Steltix. All rights reserved.
//


import UIKit

class TableControllerDashboard: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var lastUpdateLBL: UILabel!
    @IBOutlet var tableView: UITableView!
    
    func keepUpdating(){
        
        print("just refresh table")
        Globals.updateDashboardWatchlists()
        self.tableView.reloadData()
        var connectionStatus=""
        if (Globals.sharedGlobal.connectionStatus=="Connected") {connectionStatus="Online   "} else {connectionStatus="Offline   "}
        self.lastUpdateLBL.text=connectionStatus + Globals.sharedGlobal.lastUpdated
        
        DispatchQueue.global(qos: .background).async {
            print("Start update on background thread")
            Globals.updateWatchlists()
            
            self.tableView.reloadData()
            var connectionStatus=""
            if (Globals.sharedGlobal.connectionStatus=="Connected") {connectionStatus="Online   "} else {connectionStatus="Offline   "}
            self.lastUpdateLBL.text=connectionStatus + Globals.sharedGlobal.lastUpdated
            print("End update on background thread")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Globals.loadWatchlists()
        Globals.updateDashboardWatchlists()
        var connectionStatus=""
        if (Globals.sharedGlobal.connectionStatus=="Connected") {connectionStatus="Online   "} else {connectionStatus="Offline   "}
        self.lastUpdateLBL.text=connectionStatus + Globals.sharedGlobal.lastUpdated
  
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

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Globals.getDashboardWatchlistsFromSettings()
        return Globals.sharedGlobal.dashboardWatchLists.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDashboard") as! CellDashboard
        //cell.StatusBTN.layer.cornerRadius = 20
        //cell.StatusBTN.layer.borderWidth = 0
        cell.accessoryType = .none
        //print ("Adding to grid: " + Globals.sharedGlobal.dashboardWatchLists[indexPath.row].name )
        //print ("Rowcount: " + String(Globals.sharedGlobal.dashboardWatchLists[indexPath.row].recordCount))
        //print ("Critical: " + String(Globals.sharedGlobal.dashboardWatchLists[indexPath.row].criticalThreshold))
        //print ("Warning: " + String(Globals.sharedGlobal.dashboardWatchLists[indexPath.row].criticalThreshold))
        cell.StatusBTN.layer.cornerRadius = 0.5 * cell.StatusBTN.bounds.size.width
        cell.StatusBTN.layer.borderWidth = 0.0
        cell.StatusBTN.clipsToBounds = true
    
        if (Globals.sharedGlobal.dashboardWatchLists[indexPath.row].recordCount == -1)
        {
            
            //No data yet, leave white
            cell.StatusBTN.setTitle("", for: UIControlState.normal)
            cell.StatusBTN.layer.backgroundColor = UIColor(red:255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha:1).cgColor as CGColor
        }
        else
        {    //Make it green
            cell.StatusBTN.setTitle(String(Globals.sharedGlobal.dashboardWatchLists[indexPath.row].recordCount), for: UIControlState.normal)
            cell.StatusBTN.layer.backgroundColor = UIColor(red:83.0/255.0, green:214.0/255.0, blue:105.0/255.0, alpha:1).cgColor as CGColor
            if (Globals.sharedGlobal.dashboardWatchLists[indexPath.row].criticalThreshold>0)
            {
                //Make it red if critical
                if ( Globals.sharedGlobal.dashboardWatchLists[indexPath.row].recordCount >= Globals.sharedGlobal.dashboardWatchLists[indexPath.row].criticalThreshold)
                {
                    cell.StatusBTN.layer.backgroundColor = UIColor(red:252.0/255.0, green:99.0/255.0, blue:93.0/255.0, alpha:1).cgColor as CGColor
                }
                else
                {    //Make it orange if warning
                    if ( Globals.sharedGlobal.dashboardWatchLists[indexPath.row].recordCount >= Globals.sharedGlobal.dashboardWatchLists[indexPath.row].warningThreshold)
                    {
                        cell.StatusBTN.layer.backgroundColor = UIColor(red:253.0/255.0, green:189.0/255.0, blue:65.0/255.0, alpha:1).cgColor as CGColor
                    }
                }
            }
        }
        cell.NameLBL.text = Globals.sharedGlobal.dashboardWatchLists[indexPath.row].name
        return cell
    }
    
    
    
    
    
    
}
