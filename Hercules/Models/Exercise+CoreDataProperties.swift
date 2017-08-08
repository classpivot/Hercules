//
//  Exercise+CoreDataProperties.swift
//  Hercules
//
//  Created by Xiao Yan on 8/8/17.
//  Copyright © 2017 Class Pivot. All rights reserved.
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var weight: Double
    @NSManaged public var reps: Int32
    @NSManaged public var workout: Workout?

}
