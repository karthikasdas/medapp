//
//  ViewController.swift
//  MedApp
//
//  Created by Karthika on 4/16/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueID = segue.identifier {
            let vc = segue.destination as! LoginViewController
            switch segueID {
            case "login":
                vc.buttonText = "Login"
                break
            case "register":
                vc.buttonText = "Register"
                break
            default:
                break
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

