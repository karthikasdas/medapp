//
//  Model.swift
//  MedApp
//
//  Created by Karthika on 4/17/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import RealmSwift

@objc enum Priority : Int {
    case high = 0
    case medium
    case low
}

class Nurse: Object {
    dynamic var email = ""
    dynamic var password = ""
}

class Patient: Object {
    dynamic var nurse_email = ""
    dynamic var email = ""
    dynamic var full_name = ""
    dynamic var phone_number = ""
}

class Medicine: Object {
    dynamic var name = ""
}

class Medication_Details: Object {
    dynamic var patient_email = ""
    dynamic var medicine_name = ""
    dynamic var time = NSDate()
    dynamic var dosage = ""
    dynamic var priority = Priority.high
}
