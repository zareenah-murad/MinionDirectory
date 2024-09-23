//
//  YourCollectionViewController.swift
//  MinionDirectory
//
//  Created by Hamna Tameez on 9/22/24.
//

import UIKit

class YourCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let images = ["minions_scrapbook1", "Bob", "wedding", "Carl", "gru_minions", "Dave", "Stuart", "Kevin"] // Your image names

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Remove any existing subviews (for cell reuse)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Create the image view
        let imageView = UIImageView(frame: cell.contentView.frame)
        imageView.image = UIImage(named: images[indexPath.row])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        
        // Add the image view to the cell
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    // When an image is tapped
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImageName = images[indexPath.row]
        
        // Instantiate the image viewer ViewController and pass the image
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let imageViewerVC = storyboard.instantiateViewController(withIdentifier: "ImageViewerViewController") as? ImageViewerViewController {
            imageViewerVC.imageName = selectedImageName
            self.navigationController?.pushViewController(imageViewerVC, animated: true)
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    // Dynamically calculate the size for each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10  // Padding between cells in portrait mode
        let numberOfItemsInPortrait: CGFloat = 3 // 3 items in portrait mode
        
        // Calculate the width of a cell in portrait mode (3 items per row)
        let collectionViewWidth = collectionView.frame.width - padding * (numberOfItemsInPortrait + 1)
        let portraitItemWidth = collectionViewWidth / numberOfItemsInPortrait
        
        // In landscape, calculate how many items can fit based on portrait item size
        let numberOfItemsInLandscape = floor(collectionView.frame.width / (portraitItemWidth + padding))
        
        // Choose number of items based on the device orientation
        let numberOfItemsPerRow: CGFloat = UIDevice.current.orientation.isLandscape ? numberOfItemsInLandscape : numberOfItemsInPortrait
        
        // Calculate the item width and height (same height as width for square cells)
        let itemWidth = collectionView.frame.width - padding * (numberOfItemsPerRow + 1)
        let finalItemWidth = itemWidth / numberOfItemsPerRow
        
        return CGSize(width: finalItemWidth, height: finalItemWidth)
    }

    // Custom spacing for landscape and portrait modes
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice.current.orientation.isLandscape {
            return 10 // Custom row spacing for landscape
        } else {
            return 10 // Row spacing for portrait
        }
    }

    // Custom spacing between items in the same row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice.current.orientation.isLandscape {
            return 10 // Custom spacing between items for landscape
        } else {
            return 10 // Spacing between items for portrait
        }
    }
}
