//
//  Workout+CoreDataProperties.swift
//  
//
//  Created by Xiao Yan on 8/8/17.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var body_parts: [String]
    @NSManaged public var created_date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var template_flag: Bool
    @NSManaged public var exercise: NSOrderedSet?

}

// MARK: Generated accessors for exercise
extension Workout {

    @objc(insertObject:inExerciseAtIndex:)
    @NSManaged public func insertIntoExercise(_ value: Exercise, at idx: Int)

    @objc(removeObjectFromExerciseAtIndex:)
    @NSManaged public func removeFromExercise(at idx: Int)

    @objc(insertExercise:atIndexes:)
    @NSManaged public func insertIntoExercise(_ values: [Exercise], at indexes: NSIndexSet)

    @objc(removeExerciseAtIndexes:)
    @NSManaged public func removeFromExercise(at indexes: NSIndexSet)

    @objc(replaceObjectInExerciseAtIndex:withObject:)
    @NSManaged public func replaceExercise(at idx: Int, with value: Exercise)

    @objc(replaceExerciseAtIndexes:withExercise:)
    @NSManaged public func replaceExercise(at indexes: NSIndexSet, with values: [Exercise])

    @objc(addExerciseObject:)
    @NSManaged public func addToExercise(_ value: Exercise)

    @objc(removeExerciseObject:)
    @NSManaged public func removeFromExercise(_ value: Exercise)

    @objc(addExercise:)
    @NSManaged public func addToExercise(_ values: NSOrderedSet)

    @objc(removeExercise:)
    @NSManaged public func removeFromExercise(_ values: NSOrderedSet)

}
