//
//  BananaStocksTableViewController.swift
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/19/24.
//

import UIKit

class BananaStocksTableViewController: UITableViewController {

    var stocks: [(company: String, price: String, openPrice: String, percentChange: String, stockCode: String)] = []
    let stockSymbols = ["DOLE", "FDP", "CVGW"]  // Dole, Fresh Del Monte, and Calavo Growers

    // Zareenah API key
    // let alphaVantageAPIKey = "6S0ELJFGQOAXX8YA"
    // Alex API key
    let alphaVantageAPIKey = "7X6XST5JLM7BEYDL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStockPrices()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a cell with the identifier "StockCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        
        // Get the stock data for the current row
        let stock = stocks[indexPath.row]
        
        // Set the company name in the textLabel (left-aligned)
        cell.textLabel?.text = stock.company
        
        // Safely convert the price string to a double
        if let priceDouble = Double(stock.price) {
            // Format the price with 2 decimals and a $ sign
            let formattedPrice = String(format: "$%.2f", priceDouble)
            
            // Set the price in the detailTextLabel (right-aligned)
            cell.detailTextLabel?.text = "Current Price: \(formattedPrice)"
        } else {
            // Handle the case where price is not a valid double
            cell.detailTextLabel?.text = "Price not available"
        }
        
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Set the back button title for the next view controller (StockDetailViewController)
        let backItem = UIBarButtonItem()
        backItem.title = "Banana Stocks"  // Set the back button title
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "showStockDetails",
           let destinationVC = segue.destination as? StockDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedStock = stocks[indexPath.row]
            
            // Pass stock details to the next view controller
            destinationVC.companyName = selectedStock.company
            destinationVC.stockCode = selectedStock.stockCode
            destinationVC.price = selectedStock.price
            destinationVC.openPrice = selectedStock.openPrice
            destinationVC.percentChange = selectedStock.percentChange
        }
        
    }
    
    var isAlertPresented = false  // Add this to track if an alert is already presented

    // Show API Limit Error
    func showAPILimitError() {
        guard !isAlertPresented else { return }  // Avoid presenting a second alert
        isAlertPresented = true
        
        let alert = UIAlertController(title: "API Limit Reached", message: "You've reached the Alpha Vantage API limit for today. Please come back tomorrow.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.isAlertPresented = false
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    // Show Network Error
    func showNetworkError() {
        guard !isAlertPresented else { return }  // Avoid presenting a second alert
        isAlertPresented = true
        
        let alert = UIAlertController(title: "Network Error", message: "There was a problem fetching stock prices.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.isAlertPresented = false
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    func fetchStockPrices() {
        for symbol in stockSymbols {
            fetchStockPrice(for: symbol)
        }
    }
    
    func fetchStockPrice(for symbol: String) {
        let urlString = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=\(symbol)&apikey=\(alphaVantageAPIKey)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching stock price: \(error)")
                DispatchQueue.main.async {
                    self.showNetworkError()
                }
                return
            }
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Handle API limits
                    if let informationMessage = json["Information"] as? String, informationMessage.contains("Thank you for using Alpha Vantage!") {
                        print("API limit reached.")
                        DispatchQueue.main.async {
                            self.showAPILimitError()
                        }
                        return
                    }
                    
                    if let globalQuote = json["Global Quote"] as? [String: Any],
                       let price = globalQuote["05. price"] as? String,
                       let openPrice = globalQuote["02. open"] as? String,
                       let percentChange = globalQuote["10. change percent"] as? String{
                        
                        // Map symbol to company name
                        let companyName: String
                        switch symbol {
                            case "DOLE":
                                companyName = "Dole"
                            case "FDP":
                                companyName = "Fresh Del Monte"
                            case "CVGW":
                                companyName = "Calavo Growers"
                            default:
                                companyName = "Unknown"
                        }
                        
                        DispatchQueue.main.async {
                            // Add new stock data to your array
                            self.stocks.append((company: companyName, price: price, openPrice: openPrice, percentChange: percentChange, stockCode: symbol))
                            self.tableView.reloadData()
                        }
                    } else {
                        print("JSON parsing failed for \(symbol)")
                    }
                }
            } catch {
                print("Error parsing stock price: \(error)")
                DispatchQueue.main.async {
                    self.showNetworkError()
                }
            }
        }
        task.resume()
    }

}
