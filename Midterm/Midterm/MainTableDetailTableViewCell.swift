//
//  MainTableDetailTableViewCell.swift
//  Midterm
//
//  Created by Truong Mai on 4/27/17.
//  Copyright © 2017 IMIT. All rights reserved.
//

import UIKit

class MainTableDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFoodImage: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
