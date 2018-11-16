//
//  AlertService.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 16/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation
import UIKit

struct AlertService {
    
    static func showAlertWith(title: String = "Error",
                              message: String,
                              viewController: UIViewController) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
