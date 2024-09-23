//
//  ImageViewController.swift
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/19/24.
//

import UIKit

class ImageViewController: UIViewController {
    
    var minion: Minion?
    
    @IBOutlet weak var minionImageView: UIImageView!  // Connect ImageView for the minion's image
    @IBOutlet weak var minionNameLabel: UILabel!  // Connect UILabel for the minion's name
    @IBOutlet weak var minionDescriptionTextView: UITextView!
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Load minion data if available
        if let minion = minion {
            minionNameLabel.text = minion.name
            minionImageView.image = UIImage(named: minion.imageName)
            minionDescriptionTextView.text = minion.description
            
        } else {
            print("No minion data available")
        }
                
        // Ensure text view properties are correct
        minionDescriptionTextView.isScrollEnabled = false
        minionDescriptionTextView.isEditable = false
        
        // Call layout setup for the initial orientation
        setupConstraintsForOrientation()
    }
    // Function to handle device rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
            
        coordinator.animate(alongsideTransition: { _ in
            self.setupConstraintsForOrientation()
        })
    }
            
    // Setup constraints based on the current orientation
    func setupConstraintsForOrientation() {
        // Remove any existing constraints
        contentView.removeConstraints(contentView.constraints)
                
        let isLandscape = UIDevice.current.orientation.isLandscape
        if isLandscape {
            setupLandscapeConstraints()
        } else {
            setupPortraitConstraints()
        }
    }
        
    // Setup constraints for portrait mode
    func setupPortraitConstraints() {
        minionImageView.translatesAutoresizingMaskIntoConstraints = false
        minionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        minionDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            // Name label at the top
            minionNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            minionNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    
            // Image below name label
            minionImageView.topAnchor.constraint(equalTo: minionNameLabel.bottomAnchor, constant: 20),
            minionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            minionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                minionImageView.heightAnchor.constraint(equalToConstant: 300), // Adjust if needed
                
            // Description below image
            minionDescriptionTextView.topAnchor.constraint(equalTo: minionImageView.bottomAnchor, constant: 20),
            minionDescriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            minionDescriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                minionDescriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
        }
            
    // Setup constraints for landscape mode
    func setupLandscapeConstraints() {
        minionImageView.translatesAutoresizingMaskIntoConstraints = false
        minionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        minionDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            // Image on the left
            minionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            // Lowering the image by increasing the constant value
            minionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 40), // Increased to 40
            minionImageView.widthAnchor.constraint(equalToConstant: 250),
            minionImageView.heightAnchor.constraint(equalToConstant: 300),
                
            // Name above the description on the right
            minionNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 40), // Keeping at 40
            minionNameLabel.leadingAnchor.constraint(equalTo: minionImageView.trailingAnchor, constant: 20),
                minionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
            // Description to the right of the image
            minionDescriptionTextView.topAnchor.constraint(equalTo: minionNameLabel.bottomAnchor, constant: 8),
            minionDescriptionTextView.leadingAnchor.constraint(equalTo: minionImageView.trailingAnchor, constant: 20),
            minionDescriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            minionDescriptionTextView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
    }


}
