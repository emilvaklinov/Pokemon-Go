//
//  LoadingCell.swift
//  Pockemon Go
//
//  Created by Emil Vaklinov on 06/02/2021.
//  Copyright © 2021 Emil Vaklinov. All rights reserved.
//

import UIKit

protocol LoadingCellDelegate {
    func presentInfoView(withPokemon pokemon: Pokemon)
}

class LoadingCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    
    var delegate: LoadingCellDelegate?
    var pokemon: Pokemon? {
        didSet {
//            nameLabel.text = pokemon?.name?.capitalized
//            imageView.image = pokemon?.image
        }
    }
}
