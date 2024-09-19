//
//  ViewController.swift
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/18/24.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    lazy var imageModel = {
        return ImageModel.sharedInstance()
    }()
    
    lazy private var imageView: UIImageView? = {
        return UIImageView.init(image: self.imageModel.getImageWithName(displayImageName))
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func viewDirectoryButton(_ sender: UIButton) {
    }
    
    
    var displayImageName = "Eric"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Do any additional setup after loading the view.
//
//        if let size = self.imageView?.image?.size{
//            self.scrollView.addSubview(self.imageView!)
//            self.scrollView.contentSize = size
//            self.scrollView.minimumZoomScale = 0.1
//            self.scrollView.delegate = self
//        }
//        
    }



    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    


}
