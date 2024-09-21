//
//  ImageViewController.swift
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/19/24.
//

import UIKit

class ImageViewController: UIViewController {
    
    var minion: Minion?

    @IBOutlet weak var scrollView: UIScrollView!  // Connect ScrollView
    @IBOutlet weak var contentView: UIView!  // Connect ContentView
    @IBOutlet weak var minionImageView: UIImageView!  // Connect ImageView for the minion's image
    @IBOutlet weak var minionNameLabel: UILabel!  // Connect UILabel for the minion's name
    @IBOutlet weak var minionDescriptionTextView: UITextView!
    
    var displayImageName: String?  // Holds the image name
    var displayMinionName: String?  // Holds the minion's name
    var displayMinionDescription: String?  // Holds the minion's description

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()


        if let minion = minion {
                minionNameLabel.text = minion.name
                minionImageView.image = UIImage(named: minion.imageName)
                minionDescriptionTextView.text = minion.description
            }
        
    }
    
    // Function to setup constraints programmatically
        func setupConstraints() {
            // Disable autoresizing masks for programmatically added constraints
            minionNameLabel.translatesAutoresizingMaskIntoConstraints = false
            minionImageView.translatesAutoresizingMaskIntoConstraints = false
            minionDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false

            // Set the constraints for the contentView to match the scrollView's size
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                
                // Set the width of the contentView to be the same as the scrollView's width for proper scrolling
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])

            // Set constraints for the minionNameLabel at the top of the contentView
            NSLayoutConstraint.activate([
                minionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                minionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                minionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ])

            // Set constraints for the minionImageView below the minionNameLabel
            NSLayoutConstraint.activate([
                minionImageView.topAnchor.constraint(equalTo: minionNameLabel.bottomAnchor, constant: 16),
                minionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                minionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                minionImageView.heightAnchor.constraint(equalToConstant: 250)  // Adjust height as necessary
            ])

            // Set constraints for the minionDescriptionTextView below the minionImageView
            NSLayoutConstraint.activate([
                minionDescriptionTextView.topAnchor.constraint(equalTo: minionImageView.bottomAnchor, constant: 16),
                minionDescriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                minionDescriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                minionDescriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        }
}
