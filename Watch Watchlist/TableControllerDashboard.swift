//
//  TableControllerSubscribe.swift
//  Watch Watchlist
//
//  Created by Johan Teekens on 27/09/2016.
//  Copyright © 2016 Steltix. All rights reserved.
//


import UIKit

class TableControllerDashboard: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var refreshControl: UIRefreshControl!
    var Watchlists: [Globals.Watchlist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Globals.updateWatchlistsInSettings()
        
        Watchlists=Globals.getWatchlistsFromSettings()
        
        
        
    }
    
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Watchlists.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDashboard") as! CellDashboard
     //   cell.NameCell.text = Watchlists[indexPath.row].name
        cell.DescriptionLBL.text = Watchlists[indexPath.row].description
     //   cell.TypeCell.text = Watchlists[indexPath.row].type
        
        
        
        cell.accessoryType = .detailDisclosureButton
        
        
        return cell
    }
    
    
   
    
    
    
    
}
