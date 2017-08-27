//
//  TodayServices.swift
//  Bloodhoof
//
//  Created by Xiao Yan on 8/3/17.
//  Copyright © 2017 Xiao Yan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

typealias Result = ([NSManagedObject]) -> Void

class CoreDataService {
    
    static let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Get latest workout plan
    static func getTodayWorkoutData() -> Workout? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Workout")
        fetchRequest.predicate = NSPredicate(format: "(created_date >= %@) and (created_date < %@)", Date().startOfDay() as CVarArg, Date().endOfDay() as CVarArg)
        do {
            let workoutList = try managedContext.fetch(fetchRequest)
            return workoutList.count > 0 ? (workoutList[0] as! Workout) : nil
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    //Get last 3 workout records based on body parts
    static func getMyWorkoutPlan() -> [Workout] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Workout")
        let sortDescriptor = NSSortDescriptor(key: "created_date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
//        fetchRequest.predicate = NSPredicate(format: "body_parts CONTAINS ", Date().startOfDay() as CVarArg, Date().endOfDay() as CVarArg)
        fetchRequest.predicate = NSPredicate(format: "(created_date >= %@) and (created_date < %@)", Date().startOfDay() as CVarArg, Date().endOfDay() as CVarArg)
        do {
            let workoutList = try managedContext.fetch(fetchRequest)
            return workoutList as! [Workout]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    //get workout templates
    static func getWorkoutTemplates() -> [Workout] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Workout")
        let sortDescriptor = NSSortDescriptor(key: "created_date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        //        fetchRequest.predicate = NSPredicate(format: "body_parts CONTAINS ", Date().startOfDay() as CVarArg, Date().endOfDay() as CVarArg)
        fetchRequest.predicate = NSPredicate(format: "template_flag = true")
        do {
            let workoutList = try managedContext.fetch(fetchRequest)
            return workoutList as! [Workout]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    //deep copy a workout
    static func deepCopyWorkout(workout: Workout) -> Workout {
        let workoutEntity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
        let sectionEntity = NSEntityDescription.entity(forEntityName: "Section", in: managedContext)
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)
        
        let newWorkout = Workout(entity: workoutEntity!, insertInto: managedContext)
        newWorkout.name = workout.name
        newWorkout.created_date = NSDate()
        newWorkout.body_parts = workout.body_parts
        let newSectionList = newWorkout.mutableOrderedSetValue(forKey: "section")
        if let sections = workout.section {
            //hard copy all sections
            for section in sections {
                let newSection = Section(entity: sectionEntity!, insertInto: managedContext)
                let newExerciseList = newSection.mutableOrderedSetValue(forKey: "exercise")
                newSection.created_date = NSDate()
                newSection.name = (section as! Section).name
                newSection.index = (section as! Section).index
                if let exercises = (section as! Section).exercise {
                    //hard copy all exercises in each section
                    for exercise in exercises {
                        let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
                        newExercise.created_date = NSDate()
                        newExercise.name = (exercise as! Exercise).name
                        newExercise.weight = (exercise as! Exercise).weight
                        newExercise.reps = (exercise as! Exercise).reps
                        newExercise.done_flag = false
                        newExerciseList.add(newExercise)
                    }
                }
                newSectionList.add(newSection)
            }
        }
//        do {
//            try newWorkout.managedObjectContext?.save()
//        } catch {
//            let saveError = error as NSError
//            print(saveError)
//        }
        return newWorkout
    }
    
    //add new workout into core data
    static func addWorkout(workout: Workout) {
        do {
            try workout.managedObjectContext?.save()
        } catch {
            print(error)
        }
    }
    
    //Internal use for creating workout template
    static func createWorkoutTemplateChest() {
        let workoutEntity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
        let newWorkout = Workout(entity: workoutEntity!, insertInto: managedContext)
        newWorkout.name = "Chest Template One"
        newWorkout.created_date = NSDate()
        newWorkout.template_flag = true
        newWorkout.body_parts = [Body.chest.rawValue]
        let sections = newWorkout.mutableOrderedSetValue(forKey: "section")
        let sectionEntity = NSEntityDescription.entity(forEntityName: "Section", in: managedContext)
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)
        
        //section 0
        let newSection0 = Section(entity: sectionEntity!, insertInto: managedContext)
        newSection0.index = 0
        newSection0.name = "Section 1"
        let exercises0 = newSection0.mutableOrderedSetValue(forKey: "exercise")
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Barbell Incline Bench Press"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises0.add(newExercise)
        }
        sections.add(newSection0)
        
        //section 1
        let newSection1 = Section(entity: sectionEntity!, insertInto: managedContext)
        newSection1.index = 1
        newSection1.name = "Section 2"
        let exercises1 = newSection1.mutableOrderedSetValue(forKey: "exercise")
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Barbell Bench Press"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises1.add(newExercise)
        }
        sections.add(newSection1)
        
        //section 2
        let newSection2 = Section(entity: sectionEntity!, insertInto: managedContext)
        newSection2.index = 2
        newSection2.name = "Section 3"
        let exercises2 = newSection2.mutableOrderedSetValue(forKey: "exercise")
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Peck Dec Fly"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises2.add(newExercise)
        }
        sections.add(newSection2)
        
        //section 3
        let newSection3 = Section(entity: sectionEntity!, insertInto: managedContext)
        newSection3.index = 3
        newSection3.name = "Section 4"
        let exercises3 = newSection3.mutableOrderedSetValue(forKey: "exercise")
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Cable Triceps Extension"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises3.add(newExercise)
        }
        sections.add(newSection3)
        
        do {
            try newWorkout.managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
    
    static func createWorkoutTemplateBS() {
        let workoutEntity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
        let newWorkout = Workout(entity: workoutEntity!, insertInto: managedContext)
        newWorkout.name = "Back&Shoulder Template One"
        newWorkout.created_date = NSDate()
        newWorkout.template_flag = true
        newWorkout.body_parts = [Body.back.rawValue, Body.shoulder.rawValue]
        let sections = newWorkout.mutableOrderedSetValue(forKey: "section")
        let sectionEntity = NSEntityDescription.entity(forEntityName: "Section", in: managedContext)
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)
        
        //section 0
        let newSection0 = Section(entity: sectionEntity!, insertInto: managedContext)
        newSection0.index = 0
        newSection0.name = "Section 1"
        let exercises0 = newSection0.mutableOrderedSetValue(forKey: "exercise")
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Lat Pull"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises0.add(newExercise)
            let newExercise2 = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise2.name = "Shoulder Press"
            newExercise2.weight = 0
            newExercise2.reps = 0
            newExercise2.created_date = NSDate()
            exercises0.add(newExercise2)
        }
        sections.add(newSection0)
        
        //section 1
        let newSection1 = Section(entity: sectionEntity!, insertInto: managedContext)
        newSection1.index = 1
        newSection1.name = "Section 2"
        let exercises1 = newSection1.mutableOrderedSetValue(forKey: "exercise")
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "MTS High Row"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises1.add(newExercise)
            let newExercise2 = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise2.name = "Right Up Row"
            newExercise2.weight = 0
            newExercise2.reps = 0
            newExercise2.created_date = NSDate()
            exercises1.add(newExercise2)
        }
        sections.add(newSection1)
        
        //section 2
        let newSection2 = Section(entity: sectionEntity!, insertInto: managedContext)
        newSection2.index = 2
        newSection2.name = "Section 3"
        let exercises2 = newSection2.mutableOrderedSetValue(forKey: "exercise")
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Row"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises2.add(newExercise)
            let newExercise2 = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise2.name = "Bicep Curl"
            newExercise2.weight = 0
            newExercise2.reps = 0
            newExercise2.created_date = NSDate()
            exercises2.add(newExercise2)
        }
        sections.add(newSection2)
        
        //section 3
        let newSection3 = Section(entity: sectionEntity!, insertInto: managedContext)
        newSection3.index = 3
        newSection3.name = "Section 4"
        let exercises3 = newSection3.mutableOrderedSetValue(forKey: "exercise")
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Face Pull"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises3.add(newExercise)
            let newExercise2 = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise2.name = "Bent Over Fly"
            newExercise2.weight = 0
            newExercise2.reps = 0
            newExercise2.created_date = NSDate()
            exercises3.add(newExercise2)
        }
        sections.add(newSection3)
        
        do {
            try newWorkout.managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
    
    static func updateWorkout(workout: Workout) {
        do {
            try workout.managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
    
    static func deleteWorkout(workout: Workout) {
        
    }
    
    static func deleteExercise(exercise: Exercise) {
        self.managedContext.delete(exercise)
        
        do {
            try self.managedContext.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
}
