//
//  ViewController.swift
//  TDDMoneyExample
//
//  Created by Vadim Em on 09.05.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    func driversDemo() {
        let bookingQueue = DispatchQueue(label: "bookingQueue")
        let driverQueue = DispatchQueue(label: "driverQueue")
        driverQueue.sync {
            print("Give me the tickets")
            
            bookingQueue.sync {
                print("which movie")
            }
            
            driverQueue.sync {
                print("I'll ask my boss")
            }
        }
    }


}

