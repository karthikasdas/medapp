//
//  DatabaseOperator.swift
//  MedApp
//
//  Created by Karthika on 4/17/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import RealmSwift

public protocol Persistable {
    associatedtype ManagedObject : RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

class DatabaseOperator {
    static let realm = try! Realm()

    class func writeToRealm<T>(_ X: T) -> Bool {
        do {
            try realm.write() {
                if let nurse = X as? Nurse {
                    realm.add(nurse)
                }
                else if let patient = X as? Patient {
                    realm.add(patient)
                }
                else if let medicine = X as? Medicine {
                    realm.add(medicine)
                }
                else if let med_adm = X as? Medication_Details {
                    realm.add(med_adm)
                }
            }
        }
        catch {
            print("Caught error")
            return false
        }

        return true
    }
    
    class func getObjects<T>(objectType:String) -> [T] {
//        lazy var nurses: Results<Nurse> = { realm.objects(Nurse.self) }()
        switch objectType {
        case "Nurse":
            return Array(realm.objects(Nurse.self)) as! [T]
        case "Patient":
            return Array(realm.objects(Patient.self)) as! [T]
        case "Medicine":
            return Array(realm.objects(Medicine.self)) as! [T]
        case "Medication":
            return Array(realm.objects(Medication_Details.self)) as! [T]
        default:
            return []
        }
        
    }
    class func filterResultsWithSearchString(searchString: Nurse) -> Bool {
        let predicate = NSPredicate(format: "email == [c]%@ AND password == [c]%@",searchString.email,searchString.password) // 1
        let realmObjects = realm.objects(Nurse.self).filter(predicate)
        //any publication where .text property == special will be filtered. and filter out empty array
        if realmObjects.count > 0 {
            UserDefaults.standard.set(searchString.email, forKey: "email")
            UserDefaults.standard.set(searchString.password, forKey: "password")
            return true
        }
            return false
    }
    
}
