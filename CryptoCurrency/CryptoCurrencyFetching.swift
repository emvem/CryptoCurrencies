//
//  CryptoCurrencyFetching.swift
//  CryptoCurrency
//
//  Created by Vadim Em on 03.07.2022.
//

import Foundation

protocol CryptoCurrencyFetching {
    func getCryptoCurrencies(completion: (Result<[Currency], Error>) -> Void)
}

class MockCryptoCurrencyFetcher: CryptoCurrencyFetching {
    func getCryptoCurrencies(completion: (Result<[Currency], Error>) -> Void) {
        let coins: [Currency] = [.bitcoin(5),
                                 .bitcoin(10)]
        completion(.success(coins))
    }
}
