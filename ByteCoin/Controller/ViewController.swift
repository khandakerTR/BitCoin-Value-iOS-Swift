//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CoinChange{

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
     var coinManager = CoinManager ()

    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
    }
    func didUpdate(Update: CoinData) {
        DispatchQueue.main.async {
        let value = String(format: "%.2f",Update.rate )
       print(value)
        self.bitcoinLabel.text = value
            self.currencyLabel.text = Update.asset_id_quote
        }
    }

}
extension ViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return coinManager.currencyArray.count
    }
    
    
}
extension ViewController : UIPickerViewDelegate{

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        print("Select : \(selectedCurrency)")
        coinManager.coinPrice(for: selectedCurrency)
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    
}



