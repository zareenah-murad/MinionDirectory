//
//  SettingsViewController.swift
//  Minion
//
//  Created by Alexandra Geer on 9/19/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var difficultySegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        // Restore the switch state from UserDefaults
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        darkModeSwitch.isOn = isDarkModeEnabled
        
        // Apply the dark mode background based on the saved state
        self.view.backgroundColor = isDarkModeEnabled ? .darkGray : .white
        setupInitialConstraints()
    }
    
    func setupInitialConstraints() {
            if UIDevice.current.orientation.isLandscape {
                applyLandscapeConstraints()
            } else {
                applyPortraitConstraints()
            }
        }
        
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            
            coordinator.animate(alongsideTransition: { _ in
                if UIDevice.current.orientation.isLandscape {
                    self.applyLandscapeConstraints()
                } else {
                    self.applyPortraitConstraints()
                }
            })
        }
        
    func applyPortraitConstraints() {
        view.removeConstraints(view.constraints)

        darkModeLabel.translatesAutoresizingMaskIntoConstraints = false
        darkModeSwitch.translatesAutoresizingMaskIntoConstraints = false
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        difficultySegmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Center the darkModeLabel and darkModeSwitch vertically
            darkModeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            darkModeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),

            darkModeSwitch.centerYAnchor.constraint(equalTo: darkModeLabel.centerYAnchor),
            darkModeSwitch.leadingAnchor.constraint(equalTo: darkModeLabel.trailingAnchor, constant: 20),
            
            // Position difficultyLabel and segmented control below the dark mode controls
            difficultyLabel.topAnchor.constraint(equalTo: darkModeLabel.bottomAnchor, constant: 40),
            difficultyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),

            difficultySegmentedControl.centerYAnchor.constraint(equalTo: difficultyLabel.centerYAnchor),
            difficultySegmentedControl.leadingAnchor.constraint(equalTo: difficultyLabel.trailingAnchor, constant: 20),
            difficultySegmentedControl.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
        
        // Apply constraints for landscape mode
        func applyLandscapeConstraints() {
            view.removeConstraints(view.constraints)
            
            darkModeLabel.translatesAutoresizingMaskIntoConstraints = false
            darkModeSwitch.translatesAutoresizingMaskIntoConstraints = false
            difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
            difficultySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                // Dark Mode Label and Switch (left side)
                darkModeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
                darkModeLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -200),
                
                darkModeSwitch.centerYAnchor.constraint(equalTo: darkModeLabel.centerYAnchor),
                darkModeSwitch.leadingAnchor.constraint(equalTo: darkModeLabel.trailingAnchor, constant: 20),
                
                // Difficulty Label and Segmented Control (right side)
                difficultyLabel.topAnchor.constraint(equalTo: darkModeLabel.bottomAnchor, constant: 40),
                difficultyLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -200),
                
                difficultySegmentedControl.centerYAnchor.constraint(equalTo: difficultyLabel.centerYAnchor),
                difficultySegmentedControl.leadingAnchor.constraint(equalTo: difficultyLabel.trailingAnchor, constant: 20),
                difficultySegmentedControl.widthAnchor.constraint(equalToConstant: 250)
            ])
        }
    
    @IBAction func difficultyChanged(_ sender: UISegmentedControl) {
        var selectedDifficulty = "Beginner" // Default value
        
        // Check the selected segment index and assign the correct difficulty
        switch sender.selectedSegmentIndex {
        case 0:
            selectedDifficulty = "Beginner"
        case 1:
            selectedDifficulty = "Intermediate"
        case 2:
            selectedDifficulty = "BEA$T"
        default:
            selectedDifficulty = "Beginner"
        }
        
        // Save the selected difficulty to UserDefaults
        UserDefaults.standard.set(selectedDifficulty, forKey: "SelectedDifficulty")
        print("Difficulty Saved: \(selectedDifficulty)") // Debug statement
    }
    
    @IBAction func darkModeSwitchChanged(_ sender: UISwitch) {
        let isDarkModeEnabled = sender.isOn

        // Save the switch state to UserDefaults
        UserDefaults.standard.set(isDarkModeEnabled, forKey: "isDarkModeEnabled")

        // Apply dark mode using the AppDelegate function
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.applyDarkMode(isDark: isDarkModeEnabled)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load the saved difficulty from UserDefaults
        let savedDifficulty = UserDefaults.standard.string(forKey: "SelectedDifficulty") ?? "Beginner"
        
        // Set the segmented control based on the saved difficulty
        switch savedDifficulty {
        case "Beginner":
            difficultySegmentedControl.selectedSegmentIndex = 0
        case "Intermediate":
            difficultySegmentedControl.selectedSegmentIndex = 1
        case "BEA$T":
            difficultySegmentedControl.selectedSegmentIndex = 2
        default:
            difficultySegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
