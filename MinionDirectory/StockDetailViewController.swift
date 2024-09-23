//
//  StockDetailViewController.swift
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/19/24.
//

import UIKit

class StockDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Stock details that will be passed from the previous view controller
    var companyName: String?
    var stockCode: String?
    var price: String?
    var openPrice: String?
    var percentChange: String?

    var stockDetails: [(String, String)] = []  // Array of stock details to display in table view
    
    @IBOutlet weak var stockDetailsTableView: UITableView!
    
    @IBAction func clickMeButton(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign delegate and data source to the table view
        stockDetailsTableView.delegate = self
        stockDetailsTableView.dataSource = self
        
        // Initialize stock details with passed data (or "N/A" if any are nil)
        stockDetails = [
            ("Company", companyName ?? "N/A"),
            ("Stock Code", stockCode ?? "N/A"),
            ("Price", price ?? "N/A"),
            ("Open Price", openPrice ?? "N/A"),
            ("% Change", percentChange ?? "N/A")
        ]
        
        // Reload table view to display data
        stockDetailsTableView.reloadData()
    }
    
    // MARK: - Table View Data Source Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a cell with the identifier "StockDetailCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockDetailCell", for: indexPath)
        
        // Configure the cell with the left and right detail labels
        let detail = stockDetails[indexPath.row]
        cell.textLabel?.text = detail.0  // Left label (e.g., "Company")
        
        // For price and open price, we format the values with a $ sign and two decimal places
        if detail.0 == "Price" || detail.0 == "Open Price" {
            if let priceValue = Double(detail.1) {
                let formattedPrice = String(format: "$%.2f", priceValue)
                cell.detailTextLabel?.text = formattedPrice
                
                // Set the text color to green
                cell.detailTextLabel?.textColor = UIColor.systemGreen
            } else {
                // Handle invalid numbers
                cell.detailTextLabel?.text = "N/A"
                cell.detailTextLabel?.textColor = UIColor.label // Reset to default text color if value is invalid
            }
        } else {
            // For other fields, show the value normally
            cell.detailTextLabel?.text = detail.1
            cell.detailTextLabel?.textColor = UIColor.label // Default text color
        }
        
        return cell
    }

}
