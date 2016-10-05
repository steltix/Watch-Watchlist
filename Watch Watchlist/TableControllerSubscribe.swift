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
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        self.tableView.reloadData()
    }
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Globals.sharedGlobal.allWatchlists.count
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellSubscribe
        cell.NameLBL.text = Globals.sharedGlobal.allWatchlists[indexPath.row].name
        cell.TypeLBL.text = Globals.sharedGlobal.allWatchlists[indexPath.row].type
        cell.SubscribeSWT.tag = indexPath.row
        cell.SubscribeSWT.isOn=Globals.sharedGlobal.allWatchlists[indexPath.row].dashboard
        cell.SubscribeSWT.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        cell.accessoryType = .none
        return cell
    }
    
    func switchValueDidChange(sender:UISwitch!)
    {
        Globals.sharedGlobal.allWatchlists[sender.tag].dashboard=sender.isOn
        Globals.sharedGlobal.allWatchlists[sender.tag].recordCount = -1
        Globals.saveWatchlists()
    }
}
