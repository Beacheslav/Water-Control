//
//  WaterTableViewCell.swift
//  Water control
//
//  Created by  Baecheslav on 13.10.2019.
//  Copyright © 2019  Baecheslav. All rights reserved.
//

import UIKit

class WaterTableViewCell: UITableViewCell {

    //MARK:Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var volume: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
