//
//  ReusableCell.swift
//  Pockemon Go
//
//  Created by Emil Vaklinov on 08/02/2021.
//  Copyright © 2021 Emil Vaklinov. All rights reserved.
//

import UIKit

/// ReusableCell
class ReusableCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var contentCellView: UIView!
    @IBOutlet weak var imageCellView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageCellView.layer.cornerRadius = 15
        imageCellView.layer.backgroundColor = UIColor.mainPink().cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
