//
//  TableControllerSubscribe.swift
//  Watch Watchlist
//
//  Created by Johan Teekens on 27/09/2016.
//  Copyright © 2016 Steltix. All rights reserved.
//


import UIKit

class TableControllerDashboard: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var Watchlists: [Globals.Watchlist] = []
    
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Watchlists=Globals.getDashboardWatchlistsFromSettings()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("refresh")
        Globals.updateWatchlistsInSettings()
        Watchlists=Globals.getDashboardWatchlistsFromSettings()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    

    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Watchlists.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDashboard") as! CellDashboard
        cell.NameLBL.text = Watchlists[indexPath.row].name
        cell.DescriptionLBL.text = Watchlists[indexPath.row].description
        cell.ValueLBL.text = String(Watchlists[indexPath.row].recordCount)
        cell.accessoryType = .detailDisclosureButton
     
        
        return cell
    }
    
    
   
    
    
    
}
