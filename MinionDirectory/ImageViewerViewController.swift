//
//  ImageViewerViewController.swift
//  MinionDirectory
//
//  Created by Hamna Tameez on 9/22/24.
//


import UIKit

class ImageViewerViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String? // This will hold the name of the selected image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the scrollView delegate to self
        scrollView.delegate = self
        
        // Enable zooming in UIScrollView
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        // Load the selected image into the imageView
        if let imageName = imageName {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    // UIScrollViewDelegate method for zooming
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
