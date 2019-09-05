//
//  SentMemesTableViewCell.swift
//  MemeProtitype
//
//  Created by Hao Wu on 14.02.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
