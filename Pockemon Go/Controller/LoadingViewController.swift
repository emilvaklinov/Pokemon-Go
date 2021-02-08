//
//  LoadingViewController.swift
//  Pockemon Go
//
//  Created by Emil Vaklinov on 06/02/2021.
//  Copyright © 2021 Emil Vaklinov. All rights reserved.
//

import UIKit


class LoadingViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var table: UITableView!
    
    // MARK: - Properties
    private var pokemon: [Pokemon] = []
    private var currentPokemon: [Pokemon] = []
    private var pokemonType: [PokemonType] = []
    
    var pokemonSprite: Pokemon!
    private var is_photo_front: Bool = true
    private var front_photo: String = ""
    var cellOutlet: ReusableCell!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        fetchPokemon()
        configureSearchBar()
    }
    
    
    // MARK: - ConfigureSearchBar
    func configureSearchBar() {
        searchBar.delegate = self
        navigationController?.navigationBar.barTintColor = .brightGray()
        searchBar.backgroundColor = .brightGray()
        searchBar.tintColor = .black
        searchBar.resignFirstResponder()
    }
    
    /// Description
    /// - Parameter text: String
    /// - Returns: String
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    
    /// Description
    /// - Parameters:
    ///   - searchBar: searchBar
    ///   - searchText: text change and filtering data
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentPokemon = pokemon
            table.reloadData()
            return
        }
        currentPokemon = pokemon.filter({ Pokemon -> Bool in
            Pokemon.name.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
    }
    

    
    // MARK: - API Fetch Data
    func fetchPokemon() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")
        
        guard let u = url else {
            return
        }
        
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                self.pokemon = pokemonList.results
                self.currentPokemon = self.pokemon
                                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.front_photo = self.pokemonSprite?.url ?? ""
                    self.setImage(from: self.front_photo)
                }
            }
            catch let error {
                print("\(error)")
            }
        }.resume()
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else {return}

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.cellOutlet.imagePokemon.image = image
            }
        }
    }
    
    // MARK: - UITableViewDelegate/DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Description
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - section: section
    /// - Returns: Array of Pokemons
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPokemon.count
    }
    
    /// Description
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - indexPath: indexPath to Reusable cell
    /// - Returns: cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! ReusableCell
        cell.textLabel?.text = capitalize(text: currentPokemon[indexPath.row].name)
        return cell
    }
    
    /// Description
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - editingStyle: editing style DELETE
    ///   - indexPath: curent Pokemmon
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentPokemon.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    /// Description
    /// - Parameters:
    ///   - segue: segue description
    ///   - sender: sender destination
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSegue" {
            if let destination = segue.destination as? PokemonInfoController {
                destination.pokemon = currentPokemon[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
}
