//
//  ViewController.swift
//  CurrencyRates2
//
//  Created by Egor on 28.05.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource {
    
    //MARK: - OBJECTS
    @IBOutlet weak var testTable: UITableView!
    @IBOutlet weak var ratesField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noteField: UITextView!
    @IBOutlet weak var keyBoardBut: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var pickerBase: UIPickerView!
    @IBOutlet weak var imageFlag: UIImageView!
    
    
    var usd: Currency?
    var modelsOfCountry = Country()
    var arrayCountry: [String] = []
    var testArray: [String] = []
    var baseRate = 1.0
    var searchCountry = [String]()
    var searchCurrency = [String:Double]()
    var searching = false
    var textStory = " "

    
    var userDefaultStore = UserDefaults.standard // user default object
    var myCurrency: [String] = []
    var myValues: [Double] = []
    var actualBase = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteField.delegate = self
        keyBoardBut.isHidden = true
        noteField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ratesField.textAlignment = .center
        searchBar.searchTextField.textColor = .white
        
        //Button animation target
        clearButton.addTarget(self, action: #selector(changeState2(sender:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(changeState3(sender:)), for: .touchUpInside)
        
        
    }
    //MARK: - Data From Selection table
    @IBAction func unwindSegueToMainView(segue: UIStoryboardSegue) {
        guard  segue.identifier == "Segue" else {return}
        guard let sourceChosen = segue.source as? ChoseCurrencyController else {return}
        self.testArray = sourceChosen.testArrayChosen

    }
    
    @IBAction func pushButton(_ sender: UIButton) {
        performSegue(withIdentifier: "VC", sender: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changePlaceHolderColor()
        fetchData()
        
        pickerBase.delegate = self
        pickerBase.dataSource = self
        
        
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = true
        ratesField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_ : )), for: .editingChanged)
        print("\(arrayCountry) + table view")
    }
    //MARK: - PlaceHolder
    func changePlaceHolderColor() {
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.backgroundColor = #colorLiteral(red: 0.2756531239, green: 0.3340065181, blue: 0.4149620831, alpha: 1)
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.4900909662, green: 0.7071692348, blue: 1, alpha: 1)])
            
            textfield.textColor = #colorLiteral(red: 0.4900909662, green: 0.7071692348, blue: 1, alpha: 1)
            
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = #colorLiteral(red: 0.4900909662, green: 0.7071692348, blue: 1, alpha: 1)
                searchBar.tintColor = #colorLiteral(red: 0.4900909662, green: 0.7071692348, blue: 1, alpha: 1)
            }
        }
    }
    //Observer for textField
    @objc func textFieldDidChange(_ textField: UITextField ) {
        converInRealTime()
    }
    
    
    
    //MARK: - SaveButton Action + Animation
    @objc func changeState3(sender: UIButton) {
        
        self.animateView3(sender)
    }
    func animateView3(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
                
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    //MARK: - Saving the text to NoteVC
    @IBAction func saveText(_ sender: UIButton) {
        
        userDefaultStore.set(noteField.text, forKey: "key_value") // store textView in userDefault
        self.textStory = userDefaultStore.string(forKey: "key_value")!
        print(textStory)
        
    }
    
    //MARK: - ClearButton Animation
    @objc func changeState2(sender: UIButton) {
        self.animateView2(sender)
    }
    func animateView2(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 4, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            viewToAnimate.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }) { (_) in
            
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: .curveLinear, animations: {
                
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                viewToAnimate.tintColor = .black
            }, completion: nil)
        }
    }
    
    @IBAction func clearTextField(_ sender: UIButton) {
        noteField.text = ""
        print(testArray)
        
        
       
    }
    
    @IBAction func keyBoard(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    
    //MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !testArray.isEmpty {
            
            return testArray.count
            
        } else if searching {
            return searchCountry.count
        } else {
            
            if let currencyFetched = usd {
                
                return currencyFetched.rates.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell") as! FIrstCustomCell
        

        if let currencyFetched = self.usd {
            if searching {
                
                

                cell.currenFirstLbl.text = searchCountry[indexPath.row]

                let selectedRate2 = baseRate * currencyFetched.rates[searchCountry[indexPath.row]]!
                let round2 = String(format: "%0.1f", selectedRate2)
                cell.rateFirstlbl.text = round2
                cell.rateFirstlbl.textColor = .black
                
                

                modelsOfCountry.conditionCode = searchCountry[indexPath.row]
                cell.imageForCell.image = UIImage(named: modelsOfCountry.stringFlagImag)


            } else  {

                cell.currenFirstLbl.text = Array(currencyFetched.rates.keys)[indexPath.row]
                let selectedRate = baseRate * Array(currencyFetched.rates.values)[indexPath.row]
                let round = String(format: "%0.1f", selectedRate)
                
                
                    modelsOfCountry.conditionCode = Array(currencyFetched.rates.keys)[indexPath.row]
                    cell.imageForCell.image = UIImage(named: modelsOfCountry.stringFlagImag)
               

               
 

                cell.rateFirstlbl.text = round
                cell.rateFirstlbl.textColor = .black


            }

            return cell
    
        }
        return UITableViewCell()
    }
    //MARK: - Actions
    func converInRealTime() {
        if let isGetString = ratesField.text {
            if let isDouble = Double(isGetString) {
                baseRate = isDouble
                
                
                fetchData()
                
            }
        }
    }
    
    
    //Setup Date
    func setupDate() {
        DispatchQueue.main.async {
            
            if let currencyFetched2 = self.usd {
                self.dateLabel.text = currencyFetched2.date + " 🗓"
                
            }
        }
    }
    
    //MARK: - Parsing Json
    func fetchData () {
        
        let url = URL(string: "https://api.exchangeratesapi.io/latest?base=\(actualBase)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    self.usd = try JSONDecoder().decode(Currency.self, from: data!)
                    
                    
                    
                    if let currency2 = self.usd?.rates {
                        
                        for (key, value) in currency2 {
                            self.myCurrency.append(key as String)
                            self.myValues.append(value as Double)
                            
                        }
                    }
                }
                catch {
                    print("Parse Error")
                }
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    self.pickerBase.reloadAllComponents()
                    self.setupDate()
                    
                }
            } else {
                
                print("error")
                
            }
        } .resume()
    }
    
    //Скрытие клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK: - SearchBar delegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let currencyCountry = self.usd {
            
            searchCountry = currencyCountry.rates.keys.filter({$0.prefix(searchText.count) == searchText})
            
            searching = true
            converInRealTime()
            
            tableView.reloadData()
            
        }
    }
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        keyBoardBut.isHidden = true
        
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        keyBoardBut.isHidden = false
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        let currencyBase = UILabel(frame: CGRect(x: 20, y: 0, width: 100, height: 100))
        currencyBase.text = myCurrency[row]
        currencyBase.textColor = .white
        currencyBase.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        view.addSubview(currencyBase)
        
        
        
        return view
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        actualBase = myCurrency[row]

        modelsOfCountry.conditionCode = myCurrency[row]
        imageFlag.image = UIImage(named: modelsOfCountry.stringFlagImag)

        converInRealTime()
        pickerBase.reloadAllComponents()

    }
    
}


