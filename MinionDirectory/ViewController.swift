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
    
    @IBAction func viewDirectoryButton(_ sender: UIButton) {
    }
    
    @IBAction func viewBananaStocksButton(_ sender: UIButton) {
        // segue is handled by the storyboard connection
    }

    
    var displayImageName = "Bob"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

    
    }

}
