//
//  StartPageViewController.swift
//  Minion
//
//  Created by Alexandra Geer on 9/19/24.
//

import UIKit

class StartPageViewController: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var gameSettingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGameButton.titleLabel?.minimumScaleFactor = 0.5
        startGameButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        gameSettingsButton.titleLabel?.minimumScaleFactor = 0.5
        gameSettingsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        setupInitialConstraints()
        navigationController?.setNavigationBarHidden(false, animated: true)
        // Any setup code for the view controller goes here
    }
    
    func setupInitialConstraints() {
        // Set initial constraints based on the current orientation
        if UIDevice.current.orientation.isLandscape {
            applyLandscapeConstraints()
        } else {
            applyPortraitConstraints()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Update constraints based on orientation
        coordinator.animate(alongsideTransition: { _ in
            if UIDevice.current.orientation.isLandscape {
                self.applyLandscapeConstraints()
            } else {
                self.applyPortraitConstraints()
            }
        })
    }
    
    func applyPortraitConstraints() {
        // Remove any existing constraints
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        gameSettingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.removeConstraints(view.constraints)
        
        // Apply constraints to center buttons vertically and horizontally in portrait mode
        NSLayoutConstraint.activate([
            startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            startGameButton.widthAnchor.constraint(equalToConstant: 200),
            startGameButton.heightAnchor.constraint(equalToConstant: 50),
            
            gameSettingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameSettingsButton.topAnchor.constraint(equalTo: startGameButton.bottomAnchor, constant: 20),
            gameSettingsButton.widthAnchor.constraint(equalToConstant: 200),
            gameSettingsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func applyLandscapeConstraints() {
        // Remove any existing constraints
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        gameSettingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.removeConstraints(view.constraints)
        
        // Apply constraints to position buttons side by side in landscape mode
        NSLayoutConstraint.activate([
            startGameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startGameButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            startGameButton.widthAnchor.constraint(equalToConstant: 200),
            startGameButton.heightAnchor.constraint(equalToConstant: 50),
            
            gameSettingsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gameSettingsButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            gameSettingsButton.widthAnchor.constraint(equalToConstant: 200),
            gameSettingsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    var selectedDifficulty: String = "Beginner" // Example default value
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        print("Start Game button tapped!")
        
        let selectedDifficulty = UserDefaults.standard.string(forKey: "SelectedDifficulty") ?? "Beginner"
        print("Selected Difficulty: \(selectedDifficulty)") // Debug statement
        
        if selectedDifficulty == "Beginner" {
            performSegue(withIdentifier: "beginnerSegue", sender: self)
        } else if selectedDifficulty == "Intermediate" {
            performSegue(withIdentifier: "intermediateSegue", sender: self)
        } else if selectedDifficulty == "BEA$T" {
            performSegue(withIdentifier: "beastSegue", sender: self)
        }
    }
    
    
    
    //IBAction for when the user taps the "Game Settings" button
    @IBAction func gameSettingsTapped(_ sender: UIButton) {
        //performSegue(withIdentifier: "gameSettingsSegue", sender: self)
    }
    
    // Prepare for the segue, if you need to pass data between view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue" {
            // If needed, you can pass data to the game view controller here
            // let destinationVC = segue.destination as? GameViewController
        }
        else if segue.identifier == "gameSettingsSegue" {
            // If needed, pass data to the settings view controller here
            // let destinationVC = segue.destination as? SettingsViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check if dark mode is enabled and apply background color accordingly
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        self.view.backgroundColor = isDarkModeEnabled ? .darkGray : .white
    }
    
}
