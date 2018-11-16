//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 16/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import UIKit
import Kingfisher

protocol PokemonDetailsVCProtocol {
    func setupImage(url: URL)
    func setupLabel(id: Int)
    func setupLabel(name: String)
    func setupLabel(height: Int)
    func setupLabel(weight: Int)
    func setupLabel(experience: Int)
}

class PokemonDetailsViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var noDataLabel: UILabel!
    
    fileprivate var presenter: PokemonDetailsPresenterProtocol!
    
    //TODO: ??? HOW TO ROUTE IN MVP ???
    //FIXME: - MODEL :(
    var pokemon: Pokemon?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    //MARK: - Setup
    
    func setup() {
        setupNavigationBar()
        setupPresenter()
        setupUI()
    }
    
    func setupNavigationBar() {
        title = pokemon?.name.capitalized ?? "Details"
    }
    
    func setupPresenter() {
        presenter = PokemonDetailsPresenter(view: self)
        if let pokemon = pokemon {
            noDataLabel.isHidden = true
            presenter.setupWith(pokemon: pokemon)
        } else {
            noDataLabel.isHidden = false
        }
    }
    
    func setupUI() {
        avatarImageView.layer.addShadow()
        avatarImageView.layer.masksToBounds = true
    }
}

extension PokemonDetailsViewController: PokemonDetailsVCProtocol {
    
    func setupImage(url: URL) {
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: resource,
                                    placeholder: Constants.images.placeholder,
                                    options: nil,
                                    progressBlock: nil) { [weak self] (image, error, type, url) in
                                        self?.avatarImageView.kf.indicatorType = .none
        }
    }
    
    func setupLabel(id: Int) {
        idLabel.text = "🚀 ID: " + id.stringValue
    }
    
    func setupLabel(name: String) {
        nameLabel.text = "My name is " + name.capitalized
    }
    
    func setupLabel(height: Int) {
        heightLabel.text = "I'm \(height > 10 ? "tall" : "small"), my height is " + height.stringValue + "ft"
    }
    
    func setupLabel(weight: Int) {
        weightLabel.text = "Hey, I'm not heavy, only \(weight.stringValue) lbs"
    }
    
    func setupLabel(experience: Int) {
        experienceLabel.text = """
        My IQ is \(experience.stringValue) and your?
        Do you know what is IQ? 🤪😂😝😜
        """
    }
}
