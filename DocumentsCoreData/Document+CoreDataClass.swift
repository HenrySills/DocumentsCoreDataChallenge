//
//  Document+CoreDataClass.swift
//  DocumentsCoreData
//
//  Created by Henry Sills on 9/19/19.
//  Copyright © 2019 Henry Sills. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {
    /*
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    */
    convenience init?(name: String?, text: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Document.entity() ,insertInto: managedContext)
        
        self.name = name
        self.text = text
    }

}
