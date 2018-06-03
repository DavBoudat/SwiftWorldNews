//
//  SourcesCell.swift
//  WorldNews
//
//  Created by David on 30/05/2018.
//  Copyright © 2018 ynov. All rights reserved.
//

import UIKit

class SourceCell: UITableViewCell {
    @IBOutlet weak var Name: UILabel!
    var Source : Source?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        Source!.isEnabled = selected
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
}
