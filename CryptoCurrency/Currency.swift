//
//  Currency.swift
//  CryptoCurrency
//
//  Created by Vadim Em on 03.07.2022.
//

import Foundation

struct Currency: Equatable {
    var title: String
    var price: Double
        
    static func bitcoin(_ price: Double) -> Currency {
        Currency(title: "Bitcoin", price: price)
    }
}
