//
//  StockDetailViewController.swift
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/19/24.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    // IBOutlets for each label
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var stockCodeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var openPriceLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    
    var companyName: String?
    var stockCode: String?
    var price: String?
    var openPrice: String?
    var percentChange: String?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Set the labels with the passed stock data
        companyNameLabel.text = companyName
        stockCodeLabel.text = stockCode
                
        // Safely format the stock price with a $ sign and 2 decimals
        if let priceString = price, let priceDouble = Double(priceString) {
            let formattedPrice = String(format: "$%.2f", priceDouble)
            priceLabel.text = "\(formattedPrice)"
        } else {
            priceLabel.text = "Price not available"
        }
            
        // Safely format the open price with a $ sign and 2 decimals
        if let openPriceString = openPrice, let openPriceDouble = Double(openPriceString) {
            let formattedPrice = String(format: "$%.2f", openPriceDouble)
            openPriceLabel.text = "\(formattedPrice)"
        } else {
            openPriceLabel.text = "Open price not available"
        }
                
        percentChangeLabel.text = percentChange
    }
    
}
