//
//  CustomTableViewCell.swift
//  TopDevelopers
//
//  Created by Eduard Valentin on 13/04/2018.
//  Copyright © 2018 Eduard Valentin. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(image: UIImage,labelText:String) {
        self.cellImageView.image = image
        self.cellImageView.clipsToBounds = true
        self.cellImageView.layer.cornerRadius = self.cellImageView.layer.frame.height / 2
        self.cellLabel.text = labelText
    }
    
}
