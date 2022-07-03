//
//  LoadCurrenciesTests.swift
//  CryptoCurrencyTests
//
//  Created by Vadim Em on 28.06.2022.
//

import XCTest
@testable import CryptoCurrency

class MockCryptoCurrencyFetcher: CryptoCurrencyFetching {
    func getCryptoCurrencies(completion: (Result<[Currency], Error>) -> Void) {
        completion(.success([.bitcoin(5)]))
    }
}

class MockCryptoCurrencyFetcherFailure: CryptoCurrencyFetching {
    func getCryptoCurrencies(completion: (Result<[Currency], Error>) -> Void) {
        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "test"])))
    }
}

class LoadCurrencyTests: XCTestCase {
    
    let sut = MockCryptoCurrencyFetcher()
        
    func testLoadingCurrencies() {
        sut.getCryptoCurrencies(completion: { result in
            switch result {
            case .success(let currencies):
                XCTAssertEqual(currencies.count, 1)
                break
            case .failure(let error):
                break
            }
        })
    }
    
    func testFailLoadingCurrencies() {
        sut.getCryptoCurrencies(completion: { result in
            switch result {
            case .success(let currencies):
                XCTAssertEqual(currencies.count, 1)
                break
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "test")
                break
            }
        })
    }

    
}

