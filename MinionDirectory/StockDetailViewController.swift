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
        priceLabel.text = price
        openPriceLabel.text = openPrice
        percentChangeLabel.text = percentChange
    }
}
