//
//  BeginnerViewController.swift
//  Minion
//
//  Created by Alexandra Geer on 9/18/24.
//

import UIKit

class BeginnerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var minionImageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageStepper: UIStepper!
    @IBOutlet weak var bananaLoveLabel: UILabel!
    @IBOutlet weak var bananaSlider: UISlider!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton! // Added the submit button
    
    var minions = MinionData.minions // Access the shared minions array
    var selectedMinion: MinionQuiz!
    var selectedName: String = ""
    var selectedAge: Int = 0
    var selectedBananaLove: Float = 0.0
    var timeLeft = 60
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        setupGame()
        startTimer()
    }
    
    func setupGame() {
        // Select a random minion
        selectedMinion = minions.randomElement()
        minionImageView.image = UIImage(named: selectedMinion.image)
        
        // Initialize the picker to the first item and set the initial age and bananaLove
        pickerView.selectRow(0, inComponent: 0, animated: false)
        selectedName = minions[0].name // Initialize to the first minion in the list
        selectedAge = 10
        selectedBananaLove = 0.5
        
        // Set up the age stepper and slider initial values
        ageStepper.minimumValue = 1
        ageStepper.maximumValue = 100
        ageStepper.value = 10
        ageLabel.text = "10"
        
        bananaSlider.minimumValue = 0
        bananaSlider.maximumValue = 1
        bananaSlider.value = 0.5
        bananaLoveLabel.text = "0.5"
        
        // Reset the timer
        timeLeft = 30
        timerLabel.text = "Time left: \(timeLeft)"
    }
    
    // Picker View Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return minions.count
    }
    
    // Picker View Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return minions[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedName = minions[row].name
    }
    
    // Age Stepper
    @IBAction func ageStepperChanged(_ sender: UIStepper) {
        selectedAge = Int(sender.value)
        ageLabel.text = "\(selectedAge)"
    }
    
    @IBAction func bananaSliderChanged(_ sender: UISlider) {
        selectedBananaLove = sender.value
        bananaLoveLabel.text = String(format: "%.1f", selectedBananaLove)
    }
    
    // Start Timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeLeft -= 1
        timerLabel.text = "Time left: \(timeLeft)"
        
        if timeLeft == 0 {
            timer.invalidate()
            checkAnswer() // Check if the player lost due to timeout
        }
    }
    
    // Submit Answer
    @IBAction func submitTapped(_ sender: UIButton) {
        checkAnswer()
    }
    
    func checkAnswer() {
        // Debugging prints to see the current selections and correct values
        print("Selected Name: \(selectedName), Correct Name: \(selectedMinion.name)")
        print("Selected Age: \(selectedAge), Correct Age: \(selectedMinion.age)")
        print("Selected Banana Love: \(selectedBananaLove), Correct Banana Love: \(selectedMinion.bananaLove)")
        
        let nameCorrect = selectedName == selectedMinion.name
        let ageCorrect = selectedAge == selectedMinion.age
        let bananaLoveCorrect = abs(selectedBananaLove - selectedMinion.bananaLove) < 0.05
        
        if nameCorrect && ageCorrect && bananaLoveCorrect {
            timer.invalidate() // Stop the timer when the player wins
            showAlert(title: "You Win!", message: "Congratulations! You guessed all correctly.")
        } else if timeLeft == 0 {
            showAlert(title: "You Lose!", message: "Time's up!")
        } else {
            showAlert(title: "You Lose!", message: "Oops! Your guesses were incorrect.")
        }
    }
    
    // Helper function to show alert with play again and exit options
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // "Play Again" action
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
            self.restartGame() // Restart the game
        }))
        
        // "Exit" action
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
        
        // Check if dark mode is enabled and apply background color accordingly
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        self.view.backgroundColor = isDarkModeEnabled ? .darkGray : .white
    }
    
    // Function to restart the game
    func restartGame() {
        setupGame()
        startTimer()
    }
    
}
