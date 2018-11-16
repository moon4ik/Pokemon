//
//  ZoomImageViewController.swift
//  Pokemon
//
//  Created by Oleksii Mykhailenko on 13/11/18.
//  Copyright © 2018 Oleksii Mykhailenko. All rights reserved.
//

import UIKit

protocol ZoomImageVCProtocol {
    func setupImage(image: UIImage?)
    func showInfoAlert(text: String)
}

class ZoomImageViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    fileprivate var presenter: ZoomImagePresenter!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    //MARK: - Setup
    
    private func setup() {
        setupPresenter()
        setupScrollView()
    }
    
    private func setupPresenter() {
        presenter = ZoomImagePresenter(view: self)
        presenter.setupImage()
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
    }
    
    //MARK: - Actions
    
    @IBAction func dubleTapAction(_ sender: UITapGestureRecognizer) {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
}

extension ZoomImageViewController: ZoomImageVCProtocol {
    
    func setupImage(image: UIImage?) {
        imageView.image = image
    }
    
    func showInfoAlert(text: String) {
        AlertService.showAlertWith(message: text, viewController: self)
    }
}

extension ZoomImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
