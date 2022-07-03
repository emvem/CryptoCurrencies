//
//  LoadCurrenciesTests.swift
//  CryptoCurrencyTests
//
//  Created by Vadim Em on 28.06.2022.
//

import XCTest
@testable import CryptoCurrency

class MockCryptoCurrencyFetcherFailure: CryptoCurrencyFetching {
    func getCryptoCurrencies(completion: (Result<[Currency], Error>) -> Void) {
        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "test"])))
    }
}

class LoadCurrencyTests: XCTestCase {
            
    func testLoadingCurrencies() {
        fetchCoins(sut: MockCryptoCurrencyFetcher())

    }
    
    func testFailLoadingCurrencies() {
        fetchCoins(sut: MockCryptoCurrencyFetcherFailure())
    }

    private func fetchCoins(sut: CryptoCurrencyFetching) {
        sut.getCryptoCurrencies(completion: { result in
            switch result {
            case .success(let currencies):
                XCTAssertGreaterThan(currencies.count, 0)
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "test")
            }
        })
    }
    
}

