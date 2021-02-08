//
//  PokemonInfoController.swift
//  Pockemon Go
//
//  Created by Emil Vaklinov on 06/02/2021.
//  Copyright © 2021 Emil Vaklinov. All rights reserved.
//

import UIKit

class PokemonInfoController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var poisonLabel: UILabel!
    @IBOutlet var grassLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var abilityLabel: UILabel!
    
    // MARK: - Properties
    var pokemon: Pokemon!
    let backgroundImageView = UIImageView()
    var is_photo_front: Bool = true
    var front_photo: String = ""
    var back_photo: String = ""
    
   // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nameLabel.text = ""
        numberLabel.text = ""
        poisonLabel.text = ""
        grassLabel.text = ""
        abilityLabel.text = ""
        setBackground()
        setImageView()
        fetchPokemonData()
    }
    
    /// Description
    /// - Parameter text: text description
    /// - Returns: Array
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    /// Background view
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.sizeToFit()
        view.sendSubviewToBack(backgroundImageView)
    }
    
    /// Tap Gesture to change the image
    @objc func tapGesture() {
        if self.is_photo_front {
            self.setImage(from: back_photo)
            self.is_photo_front = false
        }
        else {
            self.setImage(from: front_photo)
            self.is_photo_front = true
        }
    }
    
    
    /// Set up of Image View
    func setImageView() {
        self.imageView.backgroundColor = UIColor.bluePok()
        self.imageView.layer.cornerRadius = 20
        self.imageView.layer.borderColor = UIColor.border().cgColor
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.borderWidth = 1
        self.imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        self.imageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - API
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else {return}
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    /// Fetching Pokemon Data
    func fetchPokemonData() {
        let url = URL(string: pokemon.url)
        
        guard let u = url else {
            return
        }
        
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                
                DispatchQueue.main.async {
                    self.nameLabel.text = self.capitalize(text: self.pokemon.name)
                    self.numberLabel.text = String(format: "%02d", pokemonData.id)
                    
                    for typeEntry in pokemonData.types {
                        if typeEntry.slot == 1 {
                            self.poisonLabel.text = self.capitalize(text: typeEntry.type.name)
                            self.poisonLabel.backgroundColor = UIColor.mainPink()
                        }
                        else if typeEntry.slot == 2 {
                            self.grassLabel.text = self.capitalize(text: typeEntry.type.name)
                            self.grassLabel.backgroundColor = UIColor.navyBluePok()                        }
                    }
                    
                    self.front_photo = pokemonData.sprites.front_default
                    self.back_photo = pokemonData.sprites.back_default
                    self.setImage(from: self.front_photo)
                    
                    self.setFlavorText(id: pokemonData.id)
                }
            }
            catch let error {
                print("\(error)")
            }
        }.resume()
    }
    
    
    /// Description
    /// - Parameter id: id description to set tex
    func setFlavorText(id: Int){
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/" + String(id) + "/")
        
        guard let u = url else {
            return
        }
        
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let flavorData = try JSONDecoder().decode(FlavorData.self, from: data)
                
                for flavorEntry in flavorData.flavor_text_entries {
                    if flavorEntry.language.name == "en" {
                        DispatchQueue.main.async {
                            self.abilityLabel.text = flavorEntry.flavor_text.replacingOccurrences(of: "\n", with: " ")
                        }
                        break
                    }
                }
            }
            catch let error {
                print("\(error)")
            }
        }.resume()
    }
    
    /// Memory worning function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }}
