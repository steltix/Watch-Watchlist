//
//  CellSubscribe.swift
//  Watch Watchlist
//
//  Created by Johan Teekens on 28/09/2016.
//  Copyright © 2016 Steltix. All rights reserved.
//

import Foundation
import UIKit



class CellSubscribe: UITableViewCell {

    
    @IBOutlet var NameLBL: UILabel!
    
    
    
    @IBOutlet var TypeLBL: UILabel!
    
        
    @IBOutlet var SubscribeSWT: UISwitch!
       
   
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

  }


