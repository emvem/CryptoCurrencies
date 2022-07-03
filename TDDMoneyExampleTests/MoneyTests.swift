//
//  MoneyTests.swift
//  TDDMoneyExampleTests
//
//  Created by Vadim Em on 09.05.2022.
//

import XCTest

class MoneyTests: XCTestCase {
    func testMultiplication() {
        let fiveDollar = Money.dollar(5)
        let tenDollars = fiveDollar.multiply(by: 2)
        XCTAssertEqual(tenDollars as! Money, Money.dollar(10))
        
        let sixDollars = Money.dollar(6)
        let twelveDollars = sixDollars.multiply(by: 2)
        XCTAssertEqual(twelveDollars as! Money, Money.dollar(12))

    }
    
    func testEquality() {
        let fiveEuro = Money.euro(5)
        XCTAssertFalse(Money.euro(6).equal(to: fiveEuro))
        XCTAssertFalse(Money.dollar(5).equal(to: fiveEuro))
        XCTAssertTrue(Money.euro(5).equal(to: fiveEuro))
    }
    
    func testSum() {
        let five = Money.dollar(5)
        let sum = five.plus(five)
        let bank = Bank()
        let result = sum.convert(bank: bank, to: .dollar)
        XCTAssertTrue(Money.dollar(10).equal(to: result))
        XCTAssertFalse(Money.euro(10).equal(to: result))
    }
    
    func testReduceMoneyDifferentCurrency() {
        let bank = Bank()
        bank.addRate(.euro, .dollar, 2);
        let result = Money.euro(2).convert(bank: bank, to: .dollar)
        XCTAssertEqual(Money.dollar(1), result)
    }
    
    func testIdentityRate() {
        XCTAssertEqual(1, Bank().getRate(from: .dollar, to: .euro))
    }
    
    func testMixedAddition() {
        let fiveBucks = Money.dollar(5)
        let tenFrancs = Money.euro(10)
        let bank = Bank()
        bank.addRate(.euro, .dollar, 2)
        let sum = Sum(augend: fiveBucks, addend: tenFrancs).multiply(by: 2)
        let result = sum.convert(bank: bank, to: .dollar)
        XCTAssertEqual(Money.dollar(20), result)
    }
    
}

enum Currency {
    case dollar
    case euro
}

struct Money: Expression, Equatable {
    private(set) var amount: Int
    private(set) var currency: Currency

    init(_ amount: Int, _ currency: Currency) {
        self.amount = amount
        self.currency = currency
    }
    
    func multiply(by multiplier: Int) -> Expression {
        Money(amount * multiplier, currency)
    }
    
    func plus(_ addend: Expression) -> Expression {
        return Sum(augend: self, addend: addend)
    }
    
    static func dollar(_ amount: Int) -> Money {
        Money(amount, .dollar)
    }
    
    static func euro(_ amount: Int) -> Money {
        Money(amount, .euro)
    }
    
    func convert(bank: Bank, to currency: Currency) -> Money {
        let rate = bank.getRate(from: self.currency, to: currency)
        return Money(amount/rate, currency)
    }
    
    func equal(to money: Money) -> Bool {
        return amount == money.amount && currency == money.currency
    }
}

protocol Expression {
    func convert(bank: Bank, to: Currency) -> Money
    func plus(_ addend: Expression) -> Expression
    func multiply(by multiplier: Int) -> Expression
}

struct Sum: Expression {
    var augend: Expression
    var addend: Expression
    
    func convert(bank: Bank, to currency: Currency) -> Money {
        let sum = augend.convert(bank: bank, to: currency).amount + addend.convert(bank: bank, to: currency).amount
        return Money(sum, currency)
    }
    
    func plus(_ addend: Expression) -> Expression {
        return Sum(augend: self, addend: addend)
    }
    
    func multiply(by multiplier: Int) -> Expression {
        return Sum(augend: augend.multiply(by: multiplier), addend: addend.multiply(by: multiplier))
    }
}

final class Bank {
    private var rates: [Pair: Int] = [:]
    
    func getRate(from: Currency, to: Currency) -> Int {
        if from == to {
            return 1
        }
        
        return rates[Pair(from: from, to: to)] ?? 1
    }
    
    func addRate(_ from: Currency, _ to: Currency, _ rate: Int) {
        rates[Pair(from: from, to: to)] = rate
    }
}

struct Pair: Equatable, Hashable {
    private let from: Currency
    private let to: Currency
    
    init(from: Currency, to: Currency) {
        self.from = from
        self.to = to
    }
}
