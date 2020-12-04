//
//  CountryModel.swift
//  CurrencyRates2
//
//  Created by Egor on 27.06.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import Foundation

class Country {
    
    var countryCondition = String()
    var conditionCode = String()
    
    let collection = ["Russia", "United States", "European Union", "Canada", "Hong Kong", "Iceland", "Philippines", "Denmark", "Hungary", "Czech Replublic", "Australia", "Romania", "Sweden", "Indonesia", "India", "Brazil", "Croatian", "Japan", "Thailand", "Switzerland", "Singapore", "Poland", "Bulgaria", "Turkey", "China", "Norway", "New Zealand", "South Africa", "Mexico", "Israel", "United Kingdom", "Korea", "Malaysia"]
    
    var stringCountry: String  {
        switch countryCondition {
        case "Russia": return "RUB"
        case "United States": return "USD"
        case "European Union": return "EUR"
        case "Canada": return "CAD"
        case "Hong Kong": return "HKD"
        case "Iceland": return "ISK"
        case "Philippines": return "PHP"
        case "Denmark": return "DKK"
        case "Hungary": return "HUF"
        case "Czech Replublic": return "CZK"
        case "Australia": return "AUD"
        case "Romania": return "RON"
        case "Sweden": return "SEK"
        case "Indonesia": return "IDR"
        case "India": return "INR"
        case "Brazil": return "BRL"
        case "Croatian": return "HRK"
        case "Japan": return "JPY"
        case "Thailand": return "THB"
        case "Switzerland": return "CHF"
        case "Singapore": return "SGD"
        case "Poland": return "PLN"
        case "Bulgaria": return "BGN"
        case "Turkey": return "TRY"
        case "China": return "CNY"
        case "Norway": return "NOK"
        case "New Zealand": return "NZD"
        case "South Africa": return "ZAR"
        case "Mexico": return "MXN"
        case "Israel": return "ILS"
        case "United Kingdom": return "GBP"
        case "Korea": return "KRW"
        case "Malaysia": return "MYR"
            
        default: return "what"
        }
    }
    
    var stringFlagImag: String  {
        switch conditionCode {
        case "RUB": return "32315 - flag"
        case "USD": return "32364 - flag states united united states usa"
        case "EUR": return "32215 - european flag union"
        case "CAD": return "32189 - canada flag"
        case "HKD": return "32237 - flag hong kong"
        case "ISK": return "Iceland-Flag"
        case "PHP": return "32309 - flag philippines"
        case "DKK": return "32203 - danish denmark flag"
        case "HUF": return "32238 - flag hungary"
        case "CZK": return "32202 - czech czech replublic flag republic"
        case "AUD": return "32166 - australia flag"
        case "RON": return "32314 - flag romania"
        case "SEK": return "32344 - flag sweden"
        case "IDR": return "32241 - flag indonesia"
        case "INR": return "32240 - flag india indian"
        case "BRL": return "32181 - brazil chest flag"
        case "HRK": return "32199 - croatian flag"
        case "JPY": return "32251 - flag japan"
        case "THB": return "32350 - flag thailand"
        case "CHF": return "32345 - flag switzerland"
        case "SGD": return "32331 - flag singapore"
        case "PLN": return "32310 - flag pl poland polska"
        case "BGN": return "32183 - bulgaria flag"
        case "TRY": return "Turkey-Flag"
        case "CNY": return "32194 - china flag"
        case "NOK": return "32301 - flag norway"
        case "NZD": return "32295 - flag new zealand"
        case "ZAR": return "32336 - africa flag south"
        case "MXN": return "Mexico-Flag"
        case "ILS": return "32246 - flag israel"
        case "GBP": return "United-Kingdom-Flag"
        case "KRW": return "32257 - flag korea"
        case "MYR": return "32273 - flag malaysia"
            
        default:  return "questionmark.square.fill"
        }
    }
}





