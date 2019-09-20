//
//  Document+CoreDataProperties.swift
//  DocumentsCoreData
//
//  Created by Henry Sills on 9/19/19.
//  Copyright © 2019 Henry Sills. All rights reserved.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var name: String?
    @NSManaged public var text: String?

}
