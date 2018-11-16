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
    func setupTitle(text: String)
    func isNoDataLabel(show: Bool)
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    //MARK: - Setup
    
    private func setup() {
        setupUI()
        presenter.updateViewController()
    }
    
    func setup(presenter: PokemonDetailsPresenter) {
        self.presenter = presenter
    }
    
    private func setupUI() {
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.addShadow()
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
    
    func setupTitle(text: String) {
        title = text.capitalized
    }
    
    func isNoDataLabel(show: Bool) {
        noDataLabel.isHidden = !show
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
        My IQ is \(experience.stringValue) and what is yours?
        Do you know what is IQ? 🤪😂😝😜
        """
    }
}
