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
        
        //section 0
        let newSection0 = Section(entity: sectionEntity!, insertInto: managedContext)
        newSection0.index = 0
        let exercises = newSection0.mutableOrderedSetValue(forKey: "exercise")
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Barbell Incline Bench Press"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises.add(newExercise)
        }
        sections.add(newSection0)
        
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Barbell Bench Press"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises.add(newExercise)
        }
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Peck Dec Fly"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises.add(newExercise)
        }
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Cable Triceps Extension"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises.add(newExercise)
        }
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
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)
        //        let exercises = newWorkout.mutableSetValue(forKey: "exercise")
        let exercises = newWorkout.mutableOrderedSetValue(forKey: "exercise")
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Lat Pull"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises.add(newExercise)
            let newExercise2 = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise2.name = "Shoulder Press"
            newExercise2.weight = 0
            newExercise2.reps = 0
            newExercise2.created_date = NSDate()
            exercises.add(newExercise2)
        }
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "MTS High Row"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises.add(newExercise)
            let newExercise2 = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise2.name = "Right Up Row"
            newExercise2.weight = 0
            newExercise2.reps = 0
            newExercise2.created_date = NSDate()
            exercises.add(newExercise2)
        }
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Row"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises.add(newExercise)
            let newExercise2 = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise2.name = "Bicep Curl"
            newExercise2.weight = 0
            newExercise2.reps = 0
            newExercise2.created_date = NSDate()
            exercises.add(newExercise2)
        }
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Face Pull"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises.add(newExercise)
            let newExercise2 = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise2.name = "Bent Over Fly"
            newExercise2.weight = 0
            newExercise2.reps = 0
            newExercise2.created_date = NSDate()
            exercises.add(newExercise2)
        }
        do {
            try newWorkout.managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
    
    static func updateWorkout(workout: Workout) {
        workout.name = "New Workout Test 1"
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
        
    }
}
