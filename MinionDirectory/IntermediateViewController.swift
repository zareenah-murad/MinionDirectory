//
//  IntermediateViewController.swift
//  Minion
//
//  Created by Alexandra Geer on 9/22/24.
//

import UIKit

class IntermediateViewController: UIViewController {
    
    @IBOutlet weak var minionImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField! // Free response for name
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageStepper: UIStepper!
    @IBOutlet weak var bananaLoveLabel: UILabel!
    @IBOutlet weak var bananaSlider: UISlider!
    @IBOutlet weak var timerLabel: UILabel!
    
    var minions = MinionData.minions // Access the shared minions array
    var selectedMinion: MinionQuiz!
    var selectedName: String = ""
    var selectedAge: Int = 0
    var selectedBananaLove: Float = 0.0
    var timeLeft = 30 
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        nameTextField.delegate = self // Set the text field delegate for free response
        
        setupGame()
        startTimer()
    }
    
    func setupGame() {
        // Select a random minion
        selectedMinion = minions.randomElement()
        minionImageView.image = UIImage(named: selectedMinion.image)
        
        // Initialize the nameTextField, age stepper, and banana slider
        nameTextField.text = ""
        selectedAge = 10
        selectedBananaLove = 0.5
        
        ageStepper.minimumValue = 1
        ageStepper.maximumValue = 100
        ageStepper.value = 10
        ageLabel.text = "10"
        
        bananaSlider.minimumValue = 0
        bananaSlider.maximumValue = 1
        bananaSlider.value = 0.5
        bananaLoveLabel.text = "0.5"
        
        timeLeft = 30 // Set to 20 seconds for Beast mode
        timerLabel.text = "Time left: \(timeLeft)"
    }
    
    @IBAction func ageStepperChanged(_ sender: UIStepper) {
        selectedAge = Int(sender.value)
        ageLabel.text = "\(selectedAge)"
    }
    
    @IBAction func bananaSliderChanged(_ sender: UISlider) {
        selectedBananaLove = sender.value
        bananaLoveLabel.text = String(format: "%.1f", selectedBananaLove)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeLeft -= 1
        timerLabel.text = "Time left: \(timeLeft)"
        
        if timeLeft == 0 {
            timer.invalidate()
            checkAnswer()
        }
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        checkAnswer()
    }
    
    func checkAnswer() {
        selectedName = nameTextField.text ?? ""
        
        let nameCorrect = selectedName.lowercased() == selectedMinion.name.lowercased()
        let ageCorrect = selectedAge == selectedMinion.age
        let bananaLoveCorrect = abs(selectedBananaLove - selectedMinion.bananaLove) < 0.05
        
        if nameCorrect && ageCorrect && bananaLoveCorrect {
            timer.invalidate()
            showAlert(title: "You Win!", message: "Congratulations! You guessed all correctly.")
        } else if timeLeft == 0 {
            showAlert(title: "You Lose!", message: "Time's up!")
        } else {
            showAlert(title: "You Lose!", message: "Oops! Your guesses were incorrect.")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            self.restartGame()
        }))
        
        alert.addAction(UIAlertAction(title: "Exit", style: .destructive, handler: { _ in
            // Navigate back to the Start Game screen
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        self.view.backgroundColor = isDarkModeEnabled ? .darkGray : .white
    }
    
    func restartGame() {
        setupGame()
        startTimer()
    }
}

// Make the ViewController conform to UITextFieldDelegate for handling text input
extension IntermediateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
}
