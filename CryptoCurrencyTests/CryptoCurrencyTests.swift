//
//  CryptoCurrencyTests.swift
//  CryptoCurrencyTests
//
//  Created by Vadim Em on 26.06.2022.
//

import XCTest
@testable import CryptoCurrency

class CryptoCurrencyTests: XCTestCase {
    
    func testCurrency() {
        let sut = Currency.bitcoin(5)
        XCTAssertNotEqual(sut, Currency(title: "tt", price: 5))
        XCTAssertNotEqual(sut, Currency(title: "Bitcoin", price: 10))
        XCTAssertEqual(sut, Currency(title: "Bitcoin", price: 5))
    }

}
