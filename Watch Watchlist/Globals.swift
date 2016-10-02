//
//  Globals.swift
//  Watch Watchlist
//
//  Created by Johan Teekens on 28/09/2016.
//  Copyright © 2016 Steltix. All rights reserved.
//

import Foundation
import UIKit

class Globals {
    struct Watchlist {
        var name:String
        var description:String
        var type:String
        var omwObjectName:String
        var user:String
        var currentTriggerStatus:String
        var warningThreshold:Int
        var criticalThreshol:Int
        var recordCount:Int
        var formOID:String
        var dashboard:Bool
        
    }
    class func getWatchlistsFromSettings() ->[Watchlist] {
        var Watchlists: [Watchlist] = []
        
        let AvailableWatchlistsString = Globals.sharedManager.availbaleWatchlists
        let data = (AvailableWatchlistsString as NSString).data(using: String.Encoding.utf8.rawValue)
        let json = JSON(data: data!)
        for item in json["items"].arrayValue {
            let ItemName = item["name"].stringValue
            let ItemDescription = item["description"].stringValue
            let ItemType = item["type"].stringValue
            let OmwObjectName = item["omwObjectName"].stringValue
            let User = item["user"].stringValue
            let CurrentTriggerStatus = item["currentTriggerStatus"].stringValue
            let WarningThreshold = item["warningThreshold"].intValue
            let CriticalThreshol = item["criticalThreshol"].intValue
            let RecordCount = item["recordCount"].intValue
            let FormOID = item["formOID"].stringValue
            let ItemOnDashboard=item["onDashboard"].stringValue.contains("yes")
            Watchlists.append(Watchlist(name: ItemName, description: ItemDescription, type: ItemType, omwObjectName: OmwObjectName, user: User, currentTriggerStatus: CurrentTriggerStatus , warningThreshold: WarningThreshold, criticalThreshol: CriticalThreshol, recordCount: RecordCount, formOID: FormOID, dashboard: ItemOnDashboard ))
        }
        return Watchlists
    }
    
    class func getDashboardWatchlistsFromSettings() ->[Watchlist] {
        var Watchlists: [Watchlist] = []
        
        let AvailableWatchlistsString = Globals.sharedManager.availbaleWatchlists
        let data = (AvailableWatchlistsString as NSString).data(using: String.Encoding.utf8.rawValue)
        let json = JSON(data: data!)
        for item in json["items"].arrayValue {
            let ItemName = item["name"].stringValue
            let ItemDescription = item["description"].stringValue
            let ItemType = item["type"].stringValue
            let OmwObjectName = item["omwObjectName"].stringValue
            let User = item["user"].stringValue
            let CurrentTriggerStatus = item["currentTriggerStatus"].stringValue
            let WarningThreshold = item["warningThreshold"].intValue
            let CriticalThreshol = item["criticalThreshol"].intValue
            let RecordCount = item["recordCount"].intValue
            let FormOID = item["formOID"].stringValue
            let ItemOnDashboard=item["onDashboard"].stringValue.contains("yes")
            if (item["onDashboard"].stringValue.contains("yes"))
            {
                Watchlists.append(Watchlist(name: ItemName, description: ItemDescription, type: ItemType, omwObjectName: OmwObjectName, user: User, currentTriggerStatus: CurrentTriggerStatus , warningThreshold: WarningThreshold, criticalThreshol: CriticalThreshol, recordCount: RecordCount, formOID: FormOID, dashboard: ItemOnDashboard ))
            }
        }
        return Watchlists
        
    }
    
    class func setWatchlistsInSettings(Watchlists: [Watchlist]) {
        var AvailableWatchlistsString="{\"items\" : ["
        var ItemOnDashboard = ""
        var recordcounter = 0
        
        for item in Watchlists
            
        {
            let ItemName = item.name
            let ItemDescription = item.description
            let ItemType = item.type
            let OmwObjectName = item.omwObjectName
            let User = item.user
            let CurrentTriggerStatus = item.currentTriggerStatus
            let WarningThreshold = String(item.warningThreshold)
            let CriticalThreshold = String(item.criticalThreshol)
            let RecordCount = String(item.recordCount)
            let FormOID = item.formOID
            if (item.dashboard) { ItemOnDashboard="yes"} else {ItemOnDashboard="no"}
            if (recordcounter>0) {AvailableWatchlistsString += ", " }
            AvailableWatchlistsString += "{ \"name\": \"" + ItemName + "\", "
            AvailableWatchlistsString += "\"description\": \"" + ItemDescription + "\", "
            AvailableWatchlistsString += "\"type\": \"" + ItemType  + "\", "
            AvailableWatchlistsString += "\"omwObjectName\": \"" + OmwObjectName + "\", "
            AvailableWatchlistsString += "\"user\": \"" + User + "\" , "
            AvailableWatchlistsString += "\"currentTriggerStatus\": \"" + CurrentTriggerStatus + "\", "
            AvailableWatchlistsString += "\"warningThreshold\": \"" + WarningThreshold + "\"  "
            AvailableWatchlistsString += ", \"criticalThreshold\": \"" + CriticalThreshold + "\", "
            AvailableWatchlistsString += "\"recordCount\": \"" + RecordCount + "\"  , "
            AvailableWatchlistsString += "\"formOID\": \"" + FormOID + "\"  , "
            AvailableWatchlistsString += "\"onDashboard\": \"" + ItemOnDashboard + "\"}"
            recordcounter += 1
            
        }
        AvailableWatchlistsString +=  "]}"
        
        //  print ("String to be saved:" + AvailableWatchlistsString)
        Globals.sharedManager.availbaleWatchlists=AvailableWatchlistsString
        //    print (AvailableWatchlistsString)
        
        
    }
    
    public var connectionStatus: String {
        get {
            return (UserDefaults.standard.value(forKey: "connectionStatus") as! String?)!
        }
        set {
            UserDefaults.standard.set(newValue , forKey: "connectionStatus")
            
        }
    }
    
    public var username: String {
        get {
            if (UserDefaults.standard.object(forKey: "username") != nil){
                return (UserDefaults.standard.value(forKey: "username") as! String?)!
            }
            else
            {
                return ""
            }}
        set {
            UserDefaults.standard.set(newValue , forKey: "username")
            
        }
    }
    
    public var password: String {
        get {
            if (UserDefaults.standard.object(forKey: "password") != nil){
                return (UserDefaults.standard.value(forKey: "password") as! String?)!
            }
            else
            {
                return ""
            }}
        set {
            UserDefaults.standard.set(newValue , forKey: "password")
            
        }
    }
    public var URL: String {
        get {
            if (UserDefaults.standard.object(forKey: "URL") != nil){
                return (UserDefaults.standard.value(forKey: "URL") as! String?)!
            }
            else
            {
                return ""
            }}
        set {
            UserDefaults.standard.set(newValue , forKey: "URL")
            
        }
    }
    
    public var availbaleWatchlists: String {
        get {
            if (UserDefaults.standard.object(forKey: "AvailableWatchlists") != nil){
                return (UserDefaults.standard.value(forKey: "AvailableWatchlists") as! String?)!
            }
            else
            {
                return ""
            }}
        set {
            UserDefaults.standard.set(newValue , forKey: "AvailableWatchlists")
            
        }
    }
    
    public var dashboardWatchlists: String {
        get {
            return (UserDefaults.standard.value(forKey: "DashboardWatchlists") as! String?)!
        }
        set {
            UserDefaults.standard.set(newValue , forKey: "DashboardWatchlists")
            
        }
    }
    
    class var sharedManager: Globals {
        struct Static {
            static let instance = Globals()
        }
        return Static.instance
    }
    
    class func updateWatchlistsInSettings() {
        
        var JDEdefaultRole = ""
        var JDEdefaultEnvironment = ""
        var JDEdefaultJasServer = ""
        var JDEActiveToken = ""
        let JDEPassword = Globals.sharedManager.password
        let JDEUser = Globals.sharedManager.username
        let JDEURL = Globals.sharedManager.URL
        let r = Just.get(JDEURL + "/jderest/defaultconfig")
        // print("DefaultConfig: " + r.text!)
        if let data = r.text!.data(using: String.Encoding.utf8) {
            let json = JSON(data: data)
            JDEdefaultEnvironment=json["defaultEnvironment"].stringValue
            JDEdefaultRole=json["defaultRole"].stringValue
            JDEdefaultJasServer=json["defaultJasServer"].stringValue
            for item in json["capabilityList"].arrayValue {
                let AISItem=item["name"].stringValue
                //    print(AISItem)
                if (AISItem.contains("availableWatchlists"))
                {
                    Globals.sharedManager.connectionStatus="Connected"
                }
                else {
                    Globals.sharedManager.connectionStatus="Connected but feature availableWatchlistsCheck not available on server"
                }
            }
        }
        
        //get Token
        let s = Just.post(JDEURL + "/jderest/tokenrequest", json:["password":JDEPassword,".type":" com.oracle.e1.jdemf.LoginRequest","ssoEnabled":false,"applicationName":"M03015","username":JDEUser,"role":JDEdefaultRole,"environment":JDEdefaultEnvironment,"jasserver":JDEdefaultJasServer,"deviceName":UIDevice.current.name])
        //print("token request result: " + s.text!)
        if let data = s.text!.data(using: String.Encoding.utf8) {
            let json = JSON(data: data)
            JDEActiveToken=json["userInfo"]["token"].stringValue
            // print(JDEActiveToken)
        }
        
        //get Watchlists
        var RetreivedlistForRevomal: [String] = []
        var Watchlists: [Globals.Watchlist] = []
        Watchlists=Globals.getWatchlistsFromSettings()
        
        let t = Just.post(JDEURL + "/jderest/udomanager/getallobjects", json:["udoType":"WATCHLIST","environment":JDEdefaultEnvironment,"token":JDEActiveToken,"jasserver":JDEdefaultJasServer,"ssoEnabled":false,"role":JDEdefaultRole,"deviceName":UIDevice.current.name])
        // print(t.text)
        if let data = t.text!.data(using: String.Encoding.utf8) {
            let json = JSON(data: data)
            for item in json["udoObjects"].arrayValue {
                // print ("Type: " + item["group"].stringValue)
                let WatchlistGroup=item["group"].stringValue
                //  print (index , WatchlistGroup)
                
                for wlitem in item["items"].arrayValue{
                    let ItemName = wlitem["name"].stringValue
                    let ItemDescription = wlitem["description"].stringValue
                    let ItemType = WatchlistGroup
                    let OmwObjectName = wlitem["omwObjectName"].stringValue
                    let User = wlitem["user"].stringValue
                    let CurrentTriggerStatus = "NA"
                    let WarningThreshold = 0
                    let CriticalThreshol = 0
                    let RecordCount = 0
                    let FormOID = "NA"
                    let ItemOnDashboard=false
                    RetreivedlistForRevomal.append(OmwObjectName)
                    var appendAction=true
                    //print(OmwObjectName)
                    for appendCheckItem in Watchlists
                    {
                        //check if append is needed
                        if (appendCheckItem.omwObjectName==OmwObjectName) {
                            //  appendAction=false
                            print (OmwObjectName + " already Exists, not adding")
                            appendAction=false
                        }
                    }
                    if (appendAction)
                    {
                        Watchlists.append(Watchlist(name: ItemName, description: ItemDescription, type: ItemType, omwObjectName: OmwObjectName, user: User, currentTriggerStatus: CurrentTriggerStatus , warningThreshold: WarningThreshold, criticalThreshol: CriticalThreshol, recordCount: RecordCount, formOID: FormOID, dashboard: ItemOnDashboard ))
                        print ("Append to list: " +  OmwObjectName)
                    }
                    
                }
            }
            //check if remove is needed
            
            for (index,removeCheckItem) in Watchlists.enumerated()
            {
                var remove=true
                for (retreived) in RetreivedlistForRevomal
                {
                    if (removeCheckItem.omwObjectName==retreived) {
                        remove=false}
                    
                }
                if (remove)
                {
                    print ("Remove from list: " + Watchlists[index].omwObjectName)
                    Watchlists.remove(at: index)
                    
                }
                
            }
            
            
            Globals.setWatchlistsInSettings(Watchlists: Watchlists)
            
        }
        
        //logout
        _ = Just.post(JDEURL + "/jderest/tokenrequest/logout", json:["token":JDEActiveToken,"jasserver":JDEdefaultJasServer,"ssoEnabled":false,"role":JDEdefaultRole,"deviceName":UIDevice.current.name])
        //print("Logout: " + u.text!)
        
        
    }
    
    
    
}
