//
//  ZoomImagePresenter.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 13/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import Foundation

protocol ZoomImagePresenterProtocol {
    init(view: ZoomImageVCProtocol)
    func setupImage()
}

class ZoomImagePresenter: ZoomImagePresenterProtocol {
    
    fileprivate let view: ZoomImageVCProtocol
    
    required init(view: ZoomImageVCProtocol) {
        self.view = view
    }
    
    func setupImage() {
        view.setupImage(image: Constants.images.zoomImage)
    }
}
