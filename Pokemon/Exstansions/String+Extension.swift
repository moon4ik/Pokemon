//
//  String+Extension.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 15/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

extension String {
    
    
    /// Return Data
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    /// Remove prefix (beginning) from string
    ///
    /// - Parameter prefix: String
    /// - Returns: String
    func removePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    
    /// Remove sufix (ending) from string
    ///
    /// - Parameter sufix: String
    /// - Returns: String
    func removeSufix(_ sufix: String) -> String {
        guard self.hasSuffix(sufix) else { return self }
        return String(self.dropLast(sufix.count))
    }
    
 }
