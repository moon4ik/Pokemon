//
//  PokemonCollectionViewCell.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 14/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import UIKit
import Kingfisher

protocol PokemonCVCellProtocol {
    func setupLabel(name: String)
    func setupImage(url: URL)
}

class PokemonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.addShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = "PokéAPI"
        avatarImageView.image = Constants.images.placeholder
    }

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func identifier() -> String {
        return String(describing: self)
    }
    
}

extension PokemonCollectionViewCell: PokemonCVCellProtocol {
    
    func setupLabel(name: String) {
        nameLabel.text = name.capitalized
    }
    
    func setupImage(url: URL) {
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: resource,
                                    placeholder: nil,
                                    options: nil,
                                    progressBlock: nil) { [weak self] (image, error, type, url) in
                                        self?.avatarImageView.kf.indicatorType = .none
        }
    }
    
    
}
