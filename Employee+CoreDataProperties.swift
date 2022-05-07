//
//  Employee+CoreDataProperties.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 06.05.2022.
//
//

import Foundation
import CoreData

extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var birth: String?
    @NSManaged public var country: String?
    @NSManaged public var name: String?
    @NSManaged public var lastname: String?
    @NSManaged public var occupation: String?

}

extension Employee: Identifiable {

}
