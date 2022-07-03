//
//  CurrencyNavigationTests.swift
//  CryptoCurrencyTests
//
//  Created by Vadim Em on 28.06.2022.
//

import XCTest

protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    func start()
}

class CurrencyCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.pushViewController(UIViewController(), animated: false)
    }
}

class CurrencyNavigationTests: XCTestCase {
    let sut = CurrencyCoordinator(navigationController: UINavigationController())
    
    func test_coordinator_start() {
        XCTAssertEqual(sut.navigationController.viewControllers.count, 0)
        sut.start()
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
    }
    
}
