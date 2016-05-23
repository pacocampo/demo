//
//  iPhoneMenuTableViewCell.swift
//  rappi
//
//  Created by Francisco Ocampo Romero on 19/05/16.
//  Copyright © 2016 coldhandslabs. All rights reserved.
//

import UIKit

class iPhoneMenuTableViewCell: UITableViewCell {
  
  // MARK:Outlets
  @IBOutlet weak var itemImage_IBO: UIImageView!
  
  @IBOutlet weak var itemLabel_IBO: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
