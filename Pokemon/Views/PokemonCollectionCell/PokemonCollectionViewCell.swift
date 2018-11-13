//
//  PokemonCollectionViewCell.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 14/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import UIKit

protocol PokemonCVCellProtocol {
    func setup(name: String)
    func setup(image: UIImage)
}

class PokemonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    static func fromNib() -> PokemonCollectionViewCell {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil).first as! PokemonCollectionViewCell
    }
    
    static func identifier() -> String {
        return String(describing: self)
    }
    
}
