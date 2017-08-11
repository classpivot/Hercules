//
//  Section+CoreDataProperties.swift
//  
//
//  Created by Xiao Yan on 8/11/17.
//
//

import Foundation
import CoreData


extension Section {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Section> {
        return NSFetchRequest<Section>(entityName: "Section")
    }

    @NSManaged public var index: Int32
    @NSManaged public var exercise: NSOrderedSet?
    @NSManaged public var workout: Workout?

}

// MARK: Generated accessors for exercise
extension Section {

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
