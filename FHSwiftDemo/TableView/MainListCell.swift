//
//  MainListCell.swift
//  FHSwiftDemo
//
//  Created by Sansus soft on 03/08/17.
//  Copyright © 2017 Sansus soft. All rights reserved.
//

import UIKit

class MainListCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var viewSeperator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
