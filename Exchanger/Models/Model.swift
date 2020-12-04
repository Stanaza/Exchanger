//
//  Model.swift
//  CurrencyRates2
//
//  Created by Egor on 08.06.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation

struct Currency: Decodable {
    
    let date: String
    let rates: [String:Double]
    
}
