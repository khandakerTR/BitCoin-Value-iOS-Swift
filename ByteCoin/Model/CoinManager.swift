//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinChange {
    func didUpdate(Update: CoinData)
}
struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "ABDDCEE8-62A7-402B-B8EE-000771B5401C"
    var delegate: CoinChange?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    
    
    func coinPrice(for currency: String){
        
        print(currency)
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let bitcoinPrice = self.parseJSON(safeData){
                        print(bitcoinPrice)
                        self.delegate?.didUpdate(Update: bitcoinPrice)
                    }
                    
                
                }
            
        }

            task.resume()
    
    }
    }
    
    func parseJSON(_ data: Data) -> CoinData? {

         //Create a JSONDecoder
         let decoder = JSONDecoder()
         do {

             //try to decode the data using the CoinData structure
            let decodedData = try decoder.decode(CoinData.self, from: data)

             //Get the last property from the decoded data.
            let exchaingValue = decodedData.rate
            let currencyType = decodedData.asset_id_quote
           
             print(exchaingValue)
            
            let  exchangeInformation = CoinData(asset_id_quote: currencyType, rate: exchaingValue)
             return exchangeInformation

         } catch {

             //Catch and print any errors.
             print(error)
             return nil
         }
     }

 }

