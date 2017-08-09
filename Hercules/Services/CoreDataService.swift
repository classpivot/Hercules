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
    static func createWorkoutTemplate() {
        let workoutEntity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
        let newWorkout = Workout(entity: workoutEntity!, insertInto: managedContext)
        newWorkout.name = "Chest Template One"
        newWorkout.created_date = NSDate()
        newWorkout.template_flag = true
        newWorkout.body_parts = [Body.chest.rawValue]
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)
//        let exercises = newWorkout.mutableSetValue(forKey: "exercise")
        let exercises = newWorkout.mutableOrderedSetValue(forKey: "exercise")
        for _ in 0..<3 {
            let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
            newExercise.name = "Barbell Incline Bench Press"
            newExercise.weight = 0
            newExercise.reps = 0
            newExercise.created_date = NSDate()
            exercises.add(newExercise)
        }
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
