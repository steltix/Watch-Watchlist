//
//  ViewController.swift
//  Watch Watchlist
//
//  Created by Johan Teekens on 25/09/2016.
//  Copyright © 2016 Steltix. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
   
    
    
    //link UI elements
    @IBOutlet weak var SettingsConnectionStatusFLD: UILabel!
    @IBOutlet weak var SettingsConnectionUserFLD: UITextField!
    @IBOutlet weak var SettingsConnectionPasswordFLD: UITextField!
    @IBOutlet weak var SettingsConnectionURLFLD: UITextField!
    
    @IBOutlet var NavBAR: UINavigationBar?
    
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


      
        
        SettingsConnectionUserFLD.text=Globals.sharedGlobal.username
        SettingsConnectionPasswordFLD.text = Globals.sharedGlobal.password
        SettingsConnectionURLFLD.text  = Globals.sharedGlobal.URL
    }
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
    
    @IBAction func resignKeyboard(sender: AnyObject) {
      _ = sender.resignFirstResponder()
    }
    
    
    @IBAction func SettingsConnectionTestBTN(_ sender: AnyObject) {
        
        //Save settings
       
        Globals.sharedGlobal.password = SettingsConnectionPasswordFLD.text! as String
        Globals.sharedGlobal.username = SettingsConnectionUserFLD.text! as String
        Globals.sharedGlobal.URL = SettingsConnectionURLFLD.text! as String
        Globals.updateWatchlists()
        SettingsConnectionStatusFLD.text=Globals.sharedGlobal.connectionStatus
        if (Globals.sharedGlobal.connectionStatus=="Connected")
        {
         NavBAR?.backgroundColor=UIColor.green
        }
        else
        {NavBAR?.backgroundColor=UIColor.red
        }
        
        
           }
    
    
    @IBAction func SettingsConnectionSaveBTN(_ sender: AnyObject) {
     
        Globals.sharedGlobal.password = SettingsConnectionPasswordFLD.text! as String
        Globals.sharedGlobal.username = SettingsConnectionUserFLD.text! as String
        Globals.sharedGlobal.URL = SettingsConnectionURLFLD.text! as String

        
    }
    
    
}

        
    





