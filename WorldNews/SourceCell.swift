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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
}
