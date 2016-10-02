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

    @IBOutlet weak var NameCell: UILabel!
    @IBOutlet weak var DescriptionCell: UILabel!
    @IBOutlet weak var TypeCell: UILabel!
    @IBOutlet weak var DashboardBTN: UIButton!
    
    
   
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

  }


