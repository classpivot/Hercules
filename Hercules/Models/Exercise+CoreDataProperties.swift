//
//  Exercise+CoreDataProperties.swift
//  
//
//  Created by Xiao Yan on 8/11/17.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var created_date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var reps: Int32
    @NSManaged public var weight: Double
    @NSManaged public var section: Section?
    @NSManaged public var done_flag: Bool
}
