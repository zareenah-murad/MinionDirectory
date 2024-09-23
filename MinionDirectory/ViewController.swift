//
//  ViewController.swift
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/18/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // Declare an AVAudioPlayer instance to handle audio playback
    var audioPlayer: AVAudioPlayer?

    lazy var imageModel = {
        return ImageModel.sharedInstance()
    }()
    
    lazy private var imageView: UIImageView? = {
        return UIImageView.init(image: self.imageModel.getImageWithName(displayImageName))
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func viewDirectoryButton(_ sender: UIButton) {
        stopAudio()
            }
    
    @IBAction func viewBananaStocksButton(_ sender: UIButton) {
        stopAudio()
        
    }
    
    @IBAction func soundButton(_ sender: UIButton) {
        playAudio()
    }
    
    var displayImageName = "Bob"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Configure the audio session
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Failed to set up AVAudioSession: \(error.localizedDescription)")
            }
            
            
        }

    func playAudio() {
        // Ensure the file is in the project bundle and can be found
        if let audioURL = Bundle.main.url(forResource: "bananaSong", withExtension: "mp3") {
            print("Audio file found at: \(audioURL)")
            
            do {
                // Initialize the audio player
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.play()  // Play the audio
            } catch {
                print("Error initializing audio player: \(error.localizedDescription)")
            }
        } else {
            print("Error: Audio file not found in the bundle.")
        }
    }

        // Function to stop the audio playback
        func stopAudio() {
            if let player = audioPlayer, player.isPlaying {
                player.stop()  // Stop the audio if it's currently playing
                audioPlayer = nil  // Reset the player
                print("Audio stopped")
            }
        }
    }
