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
            nameLabel.text = pokemon?.name?.capitalized
            imageView.image = pokemon?.image
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemGroupedBackground
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var nameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPink()
        
        view.addSubview(nameLabel)
        nameLabel.center(inView: view)
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 21)
        label.text = "Bulbasaur"
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            guard let pokemon = self.pokemon else { return }
            delegate?.presentInfoView(withPokemon: pokemon)
        }
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: self.frame.height - 32)
        
        addSubview(nameContainerView)
        nameContainerView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 32)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    
}
