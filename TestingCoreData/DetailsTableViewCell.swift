//
//  DetailsTableViewCell.swift
//  TestingCoreData
//
//  Created by Ahmed on 24/01/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var report:Report!{
        didSet{
            nameLabel.text=report.name
            phoneNumberLabel.text=report.phone_number
            addressLabel.text=report.address
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class Report{
    var name:String?
    var phone_number:String?
    var address:String?
    init(name:String?,phone_number:String?,address:String?){
        self.name=name
        self.phone_number=phone_number
        self.address=address
        
    }
}
