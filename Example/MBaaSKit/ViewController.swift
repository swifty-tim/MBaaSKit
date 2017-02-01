//
//  ViewController.swift
//  MBaaSKit
//
//  Created by collegboi on 01/29/2017.
//  Copyright (c) 2017 collegboi. All rights reserved.
//

import UIKit
import MBaaSKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func testGetServer() {
//        
//        var result = [TestObject]()
//        result.getAllInBackground(ofType:TestObject.self) { (succeeded: Bool, data: [TestObject]) -> () in
//            
//            DispatchQueue.main.async {
//                if (succeeded) {
//                    result = data
//                    print("scucess")
//                } else {
//                    print("error")
//                }
//            }
//        }
//    }
//    
//    func testSever() {
//        
//        let testObject = TestObject(name: "timothy")
//        
//        testObject.sendInBackground(""){ (succeeded: Bool, data: NSData) -> () in
//            // Move to the UI thread
//            
//            DispatchQueue.main.async {
//                if (succeeded) {
//                    print("scucess")
//                } else {
//                    print("error")
//                }
//            }
//        }
//        
//    }

}

