//
//  ChoseCurrencyController.swift
//  CurrencyRates2
//
//  Created by Egor on 26.06.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class ChoseCurrencyController: UIViewController {
    
    @IBOutlet weak var tableCurrency: UITableView!
    
   
    var countryModels = Country()
    var mainVC = ViewController()
    var testArrayChosen: [String] = []
    var myIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableCurrency.delegate = self
        tableCurrency.dataSource = self
        
    }
    @IBAction func doneBut(_ sender: UIBarButtonItem) {
         performSegue(withIdentifier: "Segue", sender: nil)
    }
 
}

extension ChoseCurrencyController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countryModels.collection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCurrency.dequeueReusableCell(withIdentifier: "custumCell") as! CustomViewCell
        
       
        cell.currentLabel.text = countryModels.collection[indexPath.row]

        countryModels.countryCondition = countryModels.collection[indexPath.row]

        countryModels.conditionCode = countryModels.stringCountry
        cell.imageFlag.image = UIImage(named: countryModels.stringFlagImag)
        cell.checkImage.image = UIImage(named: "circle") 
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let myIndex = indexPath
        let actualCell = tableCurrency.cellForRow(at: myIndex) as! CustomViewCell
        
        
        
        if actualCell.checkImage.image == UIImage(named: "circle") {
            
            testArrayChosen.append(countryModels.collection[myIndex.row])
            print(testArrayChosen)
            
            
            actualCell.checkImage.image = UIImage(named: "success")
            
            
        } else {
            
            actualCell.checkImage.image = UIImage(named: "circle")
            
            if let index = testArrayChosen.firstIndex(of: countryModels.collection[myIndex.row]) {
                testArrayChosen.remove(at: index)
                print(testArrayChosen)
            }
            
        }
 
    }
}


