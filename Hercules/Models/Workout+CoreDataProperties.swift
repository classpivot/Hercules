//
//  Workout+CoreDataProperties.swift
//  Hercules
//
//  Created by Xiao Yan on 8/8/17.
//  Copyright © 2017 Class Pivot. All rights reserved.
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var name: String?
    @NSManaged public var created_date: NSDate?
    @NSManaged public var template_flag: Bool
    @NSManaged public var body_parts: NSObject?
    @NSManaged public var exercise: NSSet?

}

// MARK: Generated accessors for exercise
extension Workout {

    @objc(addExerciseObject:)
    @NSManaged public func addToExercise(_ value: Exercise)

    @objc(removeExerciseObject:)
    @NSManaged public func removeFromExercise(_ value: Exercise)

    @objc(addExercise:)
    @NSManaged public func addToExercise(_ values: NSSet)

    @objc(removeExercise:)
    @NSManaged public func removeFromExercise(_ values: NSSet)

}
