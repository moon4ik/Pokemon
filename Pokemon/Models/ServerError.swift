//
//  ServerError.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 13/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

struct ServerError: Codable {
    let errorMessage: String?
    let statusCode: Int?
}
