//
//  ByTimeCell.swift
//  COVID19
//
//  Created by Rachapol Burinwatthana on 27/4/2564 BE.
//

import UIKit

class ByTimeCell: UITableViewCell {
    
    @IBOutlet weak var txt_date: UILabel!
    @IBOutlet weak var txt_confirm: UILabel!
    @IBOutlet weak var txt_recoverd: UILabel!
    @IBOutlet weak var txt_treating: UILabel!
    @IBOutlet weak var txt_deaths: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
