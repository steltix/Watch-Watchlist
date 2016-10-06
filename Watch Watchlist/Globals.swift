//
//  WatchlistData.swift
//  Watch Watchlist
//
//  Created by Johan Teekens on 04/10/2016.
//  Copyright © 2016 Steltix. All rights reserved.
//

import Foundation
import UIKit

struct Watchlist {
    var name:String!
    var description:String!
    var type:String!
    var omwObjectName:String!
    var user:String!
    var currentTriggerStatus:String!
    var warningThreshold:Int!
    var criticalThreshold:Int!
    var recordCount:Int!
    var formOID:String!
    var dashboard:Bool!
    
    init (name:String, description:String, type:String, omwObjectName:String, user:String, currentTriggerStatus:String, warningThreshold:Int, criticalThreshold:Int, recordCount:Int, formOID:String, dashboard:Bool  )
    {
        self.name=name
        self.description=description
        self.type=type
        self.omwObjectName = omwObjectName
        self.user = user
        self.currentTriggerStatus = currentTriggerStatus
        self.warningThreshold = warningThreshold
        self.criticalThreshold = criticalThreshold
        self.recordCount = recordCount
        self.formOID = formOID
        self.dashboard = dashboard
    }
    
}

class Globals {
    
    
    static let sharedGlobal = Globals()
    
    //var testString: String="Test" //for debugging
    
    var allWatchlists:[Watchlist] = []
    var dashboardWatchLists:[Watchlist] = []
    
    public var amountCritical: String {
        get {
            if (UserDefaults.standard.object(forKey: "amountCritical") != nil){
                return (UserDefaults.standard.value(forKey: "amountCritical") as! String?)!
            }
            else
            {
                return ""
            }}
        set {
            UserDefaults.standard.set(newValue , forKey: "amountCritical")
        }
    }
    
    public var lastUpdated: String {
        get {
            if (UserDefaults.standard.object(forKey: "lastUpdated") != nil){
                return (UserDefaults.standard.value(forKey: "lastUpdated") as! String?)!
            }
            else
            {
                return ""
            }}
        set {
            UserDefaults.standard.set(newValue , forKey: "lastUpdated")
            
        }
    }
    
    public var connectionStatus: String {
        get {
            if (UserDefaults.standard.object(forKey: "connectionStatus") != nil){
                return (UserDefaults.standard.value(forKey: "connectionStatus") as! String?)!
            }
            else
            {
                return ""
            }}
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
    
    
    class func loadWatchlists()
    {
        let AvailableWatchlistsString = Globals.sharedGlobal.availbaleWatchlists
        let data = (AvailableWatchlistsString as NSString).data(using: String.Encoding.utf8.rawValue)
        let json = JSON(data: data!)
        Globals.sharedGlobal.allWatchlists.removeAll()
        for item in json["items"].arrayValue {
            let ItemName = item["name"].stringValue
            let ItemDescription = item["description"].stringValue
            let ItemType = item["type"].stringValue
            let OmwObjectName = item["omwObjectName"].stringValue
            let User = item["user"].stringValue
            let CurrentTriggerStatus = item["currentTriggerStatus"].stringValue
            let WarningThreshold = item["warningThreshold"].intValue
            let CriticalThreshold = item["criticalThreshold"].intValue
            let RecordCount = item["recordCount"].intValue
            let FormOID = item["formOID"].stringValue
            let ItemOnDashboard=item["onDashboard"].stringValue.contains("yes")
            Globals.sharedGlobal.allWatchlists.append(Watchlist(name: ItemName, description: ItemDescription, type: ItemType, omwObjectName: OmwObjectName, user: User, currentTriggerStatus: CurrentTriggerStatus , warningThreshold: WarningThreshold, criticalThreshold: CriticalThreshold, recordCount: RecordCount, formOID: FormOID, dashboard: ItemOnDashboard ))
        }
    }
    
    class func updateDashboardWatchlists()  {
        Globals.sharedGlobal.dashboardWatchLists.removeAll()
        for item in Globals.sharedGlobal.allWatchlists
        {
            if (item.dashboard==true) {Globals.sharedGlobal.dashboardWatchLists.append(item)}
        }
    }
    
    class func saveWatchlists() {
        var AvailableWatchlistsString="{\"items\" : ["
        var ItemOnDashboard = ""
        var recordcounter = 0
        for item in Globals.sharedGlobal.allWatchlists
        {
            let ItemName = item.name
            let ItemDescription = item.description
            let ItemType = item.type
            let OmwObjectName = item.omwObjectName
            let User = item.user
            let CurrentTriggerStatus = item.currentTriggerStatus
            let WarningThreshold = String(item.warningThreshold)
            let CriticalThreshold = String(item.criticalThreshold)
            let RecordCount = String(item.recordCount)
            let FormOID = item.formOID
            if (item.dashboard==true) { ItemOnDashboard="yes"} else {ItemOnDashboard="no"}
            if (recordcounter>0) {AvailableWatchlistsString += ", " }
            AvailableWatchlistsString += "{ \"name\": \"" + ItemName! + "\", "
            AvailableWatchlistsString += "\"description\": \"" + ItemDescription! + "\", "
            AvailableWatchlistsString += "\"type\": \"" + ItemType!  + "\", "
            AvailableWatchlistsString += "\"omwObjectName\": \"" + OmwObjectName! + "\", "
            AvailableWatchlistsString += "\"user\": \"" + User! + "\" , "
            AvailableWatchlistsString += "\"currentTriggerStatus\": \"" + CurrentTriggerStatus! + "\", "
            AvailableWatchlistsString += "\"warningThreshold\": \"" + WarningThreshold + "\"  "
            AvailableWatchlistsString += ", \"criticalThreshold\": \"" + CriticalThreshold + "\", "
            AvailableWatchlistsString += "\"recordCount\": \"" + RecordCount + "\"  , "
            AvailableWatchlistsString += "\"formOID\": \"" + FormOID! + "\"  , "
            AvailableWatchlistsString += "\"onDashboard\": \"" + ItemOnDashboard + "\"}"
            recordcounter += 1
        }
        AvailableWatchlistsString +=  "]}"
        //  print ("String to be saved:" + AvailableWatchlistsString)
        Globals.sharedGlobal.availbaleWatchlists=AvailableWatchlistsString
        //print (AvailableWatchlistsString)
    }
    class func updateWatchlists() {
        print ("start update")
        var JDEdefaultRole = ""
        var JDEdefaultEnvironment = ""
        var JDEdefaultJasServer = ""
        var JDEActiveToken = ""
        let JDEPassword = Globals.sharedGlobal.password
        let JDEUser = Globals.sharedGlobal.username
        let JDEURL = Globals.sharedGlobal.URL
        let r = Just.get(JDEURL + "/jderest/defaultconfig")
        if (r.ok) {
            // print("DefaultConfig: " + r.text!)
            if let data = r.text!.data(using: String.Encoding.utf8) {
                let json = JSON(data: data)
                JDEdefaultEnvironment=json["defaultEnvironment"].stringValue
                JDEdefaultRole=json["defaultRole"].stringValue
                JDEdefaultJasServer=json["defaultJasServer"].stringValue
                for item in json["capabilityList"].arrayValue {
                    let AISItem=item["name"].stringValue
                    //print(AISItem)
                    if (AISItem.contains("availableWatchlists"))
                    {
                        Globals.sharedGlobal.connectionStatus="Connected"
                    }
                    else {
                        Globals.sharedGlobal.connectionStatus="Connected but feature availableWatchlistsCheck not available on server"
                    }
                }
            }
            if (Globals.sharedGlobal.connectionStatus=="Connected")
            {
                //get Token
                let s = Just.post(JDEURL + "/jderest/tokenrequest", json:["password":JDEPassword,".type":" com.oracle.e1.jdemf.LoginRequest","ssoEnabled":false,"applicationName":"M03015","username":JDEUser,"role":JDEdefaultRole,"environment":JDEdefaultEnvironment,"jasserver":JDEdefaultJasServer,"deviceName":UIDevice.current.name])
                //     print("token request result: " + s.text!)
                if (s.ok) {
                    if let data = s.text!.data(using: String.Encoding.utf8) {
                        let json = JSON(data: data)
                        JDEActiveToken=json["userInfo"]["token"].stringValue
                        let  JDETokenResult=json["message"].stringValue
                        print ("Logon Message: " + JDETokenResult)
                        if (JDETokenResult.contains("Authorization Failure"))
                        {
                            Globals.sharedGlobal.connectionStatus="Authorization Failure"
                        }
                        // print(JDEActiveToken)
                    }}
                
                if (Globals.sharedGlobal.connectionStatus=="Connected")
                {
                    //get Watchlists
                    var RetreivedlistForRevomal: [String] = []
                    let t = Just.post(JDEURL + "/jderest/udomanager/getallobjects", json:["udoType":"WATCHLIST","environment":JDEdefaultEnvironment,"token":JDEActiveToken,"jasserver":JDEdefaultJasServer,"ssoEnabled":false,"role":JDEdefaultRole,"deviceName":UIDevice.current.name])
                    if (t.ok) {
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
                                    let CurrentTriggerStatus = "no"
                                    let WarningThreshold = -1
                                    let CriticalThreshold = -1
                                    let RecordCount = -1
                                    let FormOID = "NA"
                                    let ItemOnDashboard=false
                                    RetreivedlistForRevomal.append(OmwObjectName)
                                    var appendAction=true
                                    //print(OmwObjectName)
                                    for appendCheckItem in Globals.sharedGlobal.allWatchlists
                                    {
                                        //check if append is needed
                                        if (appendCheckItem.omwObjectName==OmwObjectName) {
                                            //  appendAction=false
                                            // print (OmwObjectName + " already Exists, not adding")
                                            appendAction=false
                                        }
                                    }
                                    if (appendAction)
                                    {
                                        Globals.sharedGlobal.allWatchlists.append(Watchlist(name: ItemName, description: ItemDescription, type: ItemType, omwObjectName: OmwObjectName, user: User, currentTriggerStatus: CurrentTriggerStatus , warningThreshold: WarningThreshold, criticalThreshold: CriticalThreshold, recordCount: RecordCount, formOID: FormOID, dashboard: ItemOnDashboard ))
                                        // print ("Append to list: " +  OmwObjectName)
                                    }
                                    Globals.saveWatchlists()
                                }
                            }
                            //check if remove is needed
                            for (index,removeCheckItem) in Globals.sharedGlobal.allWatchlists.enumerated()
                            {
                                var remove=true
                                for (retreived) in RetreivedlistForRevomal
                                {
                                    if (removeCheckItem.omwObjectName==retreived) {
                                        remove=false}
                                }
                                if (remove)
                                {
                                    
                                    // print ("Remove from list: " + Globals.sharedGlobal.allWatchlists[index].omwObjectName)
                                    Globals.sharedGlobal.allWatchlists.remove(at: index)
                                    
                                }
                            }
                        }
                        var criticalCounter=0
                        for (index,item) in Globals.sharedGlobal.allWatchlists.enumerated()
                        {
                            if (item.dashboard==true)
                            {
                                //print("Refreshing:" + item.omwObjectName)
                                let u = Just.post(JDEURL + "/jderest/watchlist", json:["watchlistObjectName":item.omwObjectName,"forceUpdate" : false, "setDirtyOnly" : false, "environment":JDEdefaultEnvironment,"token":JDEActiveToken,"jasserver":JDEdefaultJasServer,"ssoEnabled":false,"role":JDEdefaultRole,"deviceName":UIDevice.current.name])
                                if (u.ok)
                                {
                                    //   print(u.text)
                                    if let data = u.text!.data(using: String.Encoding.utf8) {
                                        let json = JSON(data: data)
                                        //print ("Updating" + Globals.sharedGlobal.allWatchlists[index].name)
                                        //print ("RowCount" + String(json["rowcount"]["records"].intValue))
                                        //print ("Critical" + String(json["criticalThreshold"].intValue))
                                        // print ("Warning" + String(json["warningThreshold"].intValue))
                                        Globals.sharedGlobal.allWatchlists[index].recordCount=json["rowcount"]["records"].intValue
                                        if (json["criticalThreshold"]=="")
                                        { Globals.sharedGlobal.allWatchlists[index].criticalThreshold = -1 }
                                        else
                                        {Globals.sharedGlobal.allWatchlists[index].criticalThreshold=json["criticalThreshold"].intValue}
                                        if (json["warningThreshold"]=="")
                                        {Globals.sharedGlobal.allWatchlists[index].warningThreshold = -1}
                                        else
                                        {Globals.sharedGlobal.allWatchlists[index].warningThreshold=json["warningThreshold"].intValue}
                                        Globals.sharedGlobal.allWatchlists[index].formOID=json["formOID"].stringValue
                                        //print ("Updating" + Globals.sharedGlobal.allWatchlists[index].name)
                                        //print ("RowCount" + String(Globals.sharedGlobal.allWatchlists[index].recordCount))
                                        //print ("Critical" + String(Globals.sharedGlobal.allWatchlists[index].criticalThreshold))
                                        //print ("Warning" + String(Globals.sharedGlobal.allWatchlists[index].warningThreshold))
                                        
                                        if ((Globals.sharedGlobal.allWatchlists[index].currentTriggerStatus=="no") && (json["rowcount"]["records"].intValue>json["criticalThreshold"].intValue))
                                        {
                                            let notificationManger = NotificationManager()
                                            notificationManger.registerForNotifications(messageText: "Critical: " + Globals.sharedGlobal.allWatchlists[index].name)
                                            Globals.sharedGlobal.allWatchlists[index].currentTriggerStatus="yes"
                                            criticalCounter += 1
                                            //Globals.sharedGlobal.amountCritical = criticalCounter
                                        }
                                        else
                                        {Globals.sharedGlobal.allWatchlists[index].currentTriggerStatus="no"}
                                    }
                                }
                                else
                                {
                                    Globals.sharedGlobal.connectionStatus="Cannot connect to URL"
                                }
                            }
                        }
                    }
                    //logout
                    _ = Just.post(JDEURL + "/jderest/tokenrequest/logout", json:["token":JDEActiveToken,"jasserver":JDEdefaultJasServer,"ssoEnabled":false,"role":JDEdefaultRole,"deviceName":UIDevice.current.name])
                    //print("Logout: " + u.text!)
                    //Globals.setWatchlistsInSettings()
                    //Globals.getDashboardWatchlistsFromSettings()
                    let now = NSDate()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
                    print(formatter.string(from: now as Date))
                    
                    Globals.sharedGlobal.lastUpdated="Last updated: " + formatter.string(from: now as Date)
                    
                }
            }
            else
            {
                Globals.sharedGlobal.connectionStatus="Cannot connect to URL"
            }
        }
        else
        {
            Globals.sharedGlobal.connectionStatus="Cannot connect to URL"
        }
    }
    
    
    
    
}


