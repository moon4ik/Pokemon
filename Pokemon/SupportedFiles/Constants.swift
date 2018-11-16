//
//  Constants.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 15/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    //MARK: - URL
    
    static let baseURL: String = "https://pokeapi.co/api/v2/"

    //MARK: - Images
    
    struct images {
        
        static let placeholder: UIImage = UIImage(named: "pokemonEgg") ?? UIImage()
        static let zoomImage: UIImage = UIImage(named: "zoomImage") ?? UIImage()
        
        struct barItems {
            static let two: UIImage = UIImage(named: "2x2") ?? UIImage()
            static let three: UIImage = UIImage(named: "3x3") ?? UIImage()
            static let four: UIImage = UIImage(named: "4x4") ?? UIImage()
        }
    }
    
    
}
