//
//  NoteViewController.swift
//  CurrencyRates2
//
//  Created by Egor on 07.06.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var keyButton: UIButton!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    var text2 = ""
    var mainVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textField.delegate = self
        textField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        keyButton.isHidden = true
        //        savingTextToNote()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        textField.delegate = self
        savingTextToNote()
    }
    
    //MARK: - Saving Method
    func savingTextToNote() {
        
        let userDef = UserDefaults.standard
        
        if userDef.string(forKey: "key_value") != nil {
            text2 = userDef.string(forKey: "key_value")!
            textField.text += "\n \(text2)"
            mainVC.userDefaultStore.removeObject(forKey: "key_value" )
        } else {
           return
        }
        
        
        textField.isUserInteractionEnabled = true
       
    }
    
    // Cancel keyBoard
    @IBAction func cancelKeyBoard(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    @IBAction func trashhAll(_ sender: UIBarButtonItem) {
        textField.text = ""
    }
    
}

extension NoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        keyButton.isHidden = true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        keyButton.isHidden = false
    }
}

