//
//  ImageCacheService.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 15/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation
import Kingfisher

struct ImageCacheService {
    
    static func setupCache() {
        ImageCache.default.maxCachePeriodInSecond = -1
        ImageCache.default.maxMemoryCost = 1
    }
}
