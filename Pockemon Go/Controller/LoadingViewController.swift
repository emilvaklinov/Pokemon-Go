//
//  LoadingViewController.swift
//  Pockemon Go
//
//  Created by Emil Vaklinov on 06/02/2021.
//  Copyright © 2021 Emil Vaklinov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LoadingViewController: UICollectionViewController {

    // MARK: - Properties
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    var searchBar: UISearchBar!
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Selectors
    
    @objc func showSearchBar() {
        configureSearchBar()
    }
    
    @objc func handleDismissal() {
       
    }
    
    // MARK: - API
    
    func fetchPokemon() {
        Service.shared.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.tintColor = .white
        
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBar
    }
    
    func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }

}

// MARK: - UISearchBarDelegate
extension LoadingViewController: UISearchBarDelegate {
    
}

// MARK: - UICollectionViewDataSource/Delegate


// MARK: - UICollectionViewDelegateFlowLayout

// MARK: - PokedexCellDelegate

// MARK: - InfoViewDelegate
