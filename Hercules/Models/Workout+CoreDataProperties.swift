//
//  Workout+CoreDataProperties.swift
//  
//
//  Created by Xiao Yan on 8/11/17.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var body_parts: [String]?
    @NSManaged public var created_date: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var template_flag: Bool
    @NSManaged public var section: NSOrderedSet?

}

// MARK: Generated accessors for section
extension Workout {

    @objc(insertObject:inSectionAtIndex:)
    @NSManaged public func insertIntoSection(_ value: Section, at idx: Int)

    @objc(removeObjectFromSectionAtIndex:)
    @NSManaged public func removeFromSection(at idx: Int)

    @objc(insertSection:atIndexes:)
    @NSManaged public func insertIntoSection(_ values: [Section], at indexes: NSIndexSet)

    @objc(removeSectionAtIndexes:)
    @NSManaged public func removeFromSection(at indexes: NSIndexSet)

    @objc(replaceObjectInSectionAtIndex:withObject:)
    @NSManaged public func replaceSection(at idx: Int, with value: Section)

    @objc(replaceSectionAtIndexes:withSection:)
    @NSManaged public func replaceSection(at indexes: NSIndexSet, with values: [Section])

    @objc(addSectionObject:)
    @NSManaged public func addToSection(_ value: Section)

    @objc(removeSectionObject:)
    @NSManaged public func removeFromSection(_ value: Section)

    @objc(addSection:)
    @NSManaged public func addToSection(_ values: NSOrderedSet)

    @objc(removeSection:)
    @NSManaged public func removeFromSection(_ values: NSOrderedSet)

}
