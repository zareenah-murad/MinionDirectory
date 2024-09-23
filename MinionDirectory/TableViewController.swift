//
//  TableViewController.swift
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/18/24.
//


import UIKit

// Minion Struct
struct Minion {
    let name: String
    let imageName: String
    let description: String
}

class TableViewController: UITableViewController {
    
    var minions: [Minion] = [
        Minion(name: "Bob", imageName: "Bob", description: "Bob is a young and cheerful Minion, and is 6 years old (in Minion years). Bob is incredibly loyal and loves making new friends. On a scale of 1-10, his love for bananas ranks at a solid 5, making him a devoted fan, though not as obsessed as some of his fellow Minions!"),
        Minion(name: "Carl", imageName: "Carl", description: "Carl is a fun-loving and quirky Minion, standing out with his single eye and love for practical jokes. At 7 years old (in Minion years), Carl has a mischievous streak, but his heart is always in the right place. On a scale of 1-10, Carl’s love for bananas is an 8, making him a true banana enthusiast!"),
        Minion(name: "Dave", imageName: "Dave", description: "Dave, at 8 years old (in Minion years), is known for being one of the more adventurous and tech-savvy Minions. His love for bananas is a respectable 6 on a scale of 1-10, meaning he enjoys them but isn’t as fanatical as some of the others."),
        Minion(name: "Kevin", imageName: "Kevin", description: "Kevin is one of the oldest and wisest of the Minions at 9 years old (in Minion years). He takes his role as a leader seriously, often looking out for his younger Minion friends. On a scale of 1-10, his love for bananas is a 9, making him one of the biggest banana fans around, always ready for a banana-fueled adventure."),
        Minion(name: "Stuart", imageName: "Stuart", description: "Stuart is the laid-back, cool Minion with a talent for music, especially the guitar. At 7 years old (in Minion years), Stuart prefers to chill and jam to his favorite tunes. His love for bananas is a steady 7 on a scale of 1-10, balancing his affection for the fruit with his other laid-back passions."),
    ]
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            // Register the cell identifiers programmatically
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ImageCell")
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RightDetailCell")

        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100


        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return minions.count
    }

    // MARK: - Navigation

    // MARK: - Cell Configurations
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let minion = minions[indexPath.row]
        
        if indexPath.row == 3 { // Right detail cell (Kevin)
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "RightDetailCell")  // Programmatic Right Detail Cell

            // Set text and detail text for the Right Detail cell
            cell.textLabel?.text = minion.name
            cell.detailTextLabel?.text = "Leader of the Minions"

            return cell
        } else if indexPath.row == 2 { // Image cell (Dave)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
            
            // Set image and text for image cell
            cell.textLabel?.text = minion.name
            cell.imageView?.image = UIImage(named: minion.imageName)
            
            return cell
        } else if indexPath.row == 4 { // Summary cell (Stuart)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryCell else {
                print("Error: Could not dequeue SummaryCell")
                return UITableViewCell() // Fallback to an empty cell if there's an error
            }

            // Hide the default textLabel since we're using custom labels
            cell.textLabel?.isHidden = true

            // Set Stuart's name in your custom label
            cell.summaryTitleLabel.text = minion.name

            // Set the detailed description in the same or another custom label if needed
            cell.summaryDetailLabel.text = minion.description
            
            return cell
        } else { // Basic cells (Bob and Carl)
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
            
            // Setting text for basic cells
            cell.textLabel?.text = minion.name
           
            return cell
        }
    }



        
    // MARK: - Table Row Selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showImage", sender: indexPath)
    }
        
    // MARK: - Prepare for Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            if let destinationVC = segue.destination as? ImageViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                // Pass the correct minion object
                let selectedMinion = minions[indexPath.row]
                destinationVC.minion = selectedMinion
            }
        }
    }
}
