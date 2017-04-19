//
//  LoginViewController.swift
//  MedApp
//
//  Created by Karthika on 4/17/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    var buttonText : String = "Login"
    
    lazy var nurses : [Nurse] = DatabaseOperator.getObjects(objectType: "Nurse") 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.setTitle(self.buttonText, for: .normal)
        // Do any additional setup after loading the view.
    }

    @IBAction func cancelClicked(_ sender: Any) {
        self.emailField.text = ""
        self.passwordField.text = ""
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        guard sender.titleLabel?.text == "Login"  else {
            guard registerNurse() else {
                showAlert()
                return
            }
            self.performSegue(withIdentifier: "patientList", sender: self)
            return
        }
        guard checkLogin() else {
            showAlert()
            return
        }
            self.performSegue(withIdentifier: "patientList", sender: self)
    }
    
    func checkLogin() -> Bool {
        let checkNurse = createNurseObject()
        guard DatabaseOperator.filterResultsWithSearchString(searchString: checkNurse) else {
            return false
        }
        return true
    }
    
    func registerNurse() -> Bool{
            let newNurse = createNurseObject()
            let dbSuccess = DatabaseOperator.writeToRealm(newNurse)
                print("Error in writing to db - \(dbSuccess)")
        guard dbSuccess else {
            return false
        }
        nurses = DatabaseOperator.getObjects(objectType: "Nurse")
        return true
    }
    
    func createNurseObject() -> Nurse {
        let nurseObj = Nurse()
        nurseObj.email = self.emailField.text!
        nurseObj.password = self.passwordField.text!
        return nurseObj
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Error", message: "You are not registered yet!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
