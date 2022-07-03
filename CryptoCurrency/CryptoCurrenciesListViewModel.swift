//
//  CryptoCurrenciesListViewModel.swift
//  CryptoCurrency
//
//  Created by Vadim Em on 03.07.2022.
//

import SwiftUI

class CryptoCurrenciesListViewModel {
    @State var coins: [Currency] = []
    
    private let coinsRepository: CryptoCurrencyFetching
    
    init(coinsRepository: CryptoCurrencyFetching) {
        self.coinsRepository = coinsRepository
    }
    
    func getCoins() {
        coinsRepository.getCryptoCurrencies(completion: { result in
            switch result {
            case .success(let currencies):
                coins = currencies
            case .failure(let error):
                print(error)
            }
        })
    }
}
