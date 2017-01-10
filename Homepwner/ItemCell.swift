//
//  ItemCell.swift
//  Homepwner
//
//  Created by Eric Dockery on 1/5/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        let captionOneFont = UIFont.preferredFont(forTextStyle: .caption1)
        serialNumberLabel.font = captionOneFont
    }
    func updateBackgroundColor(colorCode: Int) {
        switch colorCode {
        case 0:
            self.backgroundColor = UIColor.red
        case 1:
            self.backgroundColor = UIColor.green
        default:
            self.backgroundColor = UIColor.brown
        }
    }
}
