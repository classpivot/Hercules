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
    
    static func getMyWorkoutPlan() -> [Workout] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Workout")
        let sortDescriptor = NSSortDescriptor(key: "created_date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
//        fetchRequest.predicate = NSPredicate(format: "body_parts CONTAINS ", Date().startOfDay() as CVarArg, Date().endOfDay() as CVarArg)
        fetchRequest.predicate = NSPredicate(format: "(created_date >= %@) and (created_date < %@)", Date().startOfDay() as CVarArg, Date().endOfDay() as CVarArg)
        do {
            let workoutList = try managedContext.fetch(fetchRequest)
            updateWorkout(workout: workoutList[0] as! Workout)
            return workoutList as! [Workout]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    static func createWorkoutTemplate() {
        let workoutEntity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
        let newWorkout = Workout(entity: workoutEntity!, insertInto: managedContext)
        newWorkout.name = "Test Workout 1"
        newWorkout.created_date = NSDate()
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)
        let newExercise = Exercise(entity: exerciseEntity!, insertInto: managedContext)
        newExercise.name = "Text Exercise 1"
        newExercise.weight = 100
        newExercise.reps = 12
        let exercises = newWorkout.mutableSetValue(forKey: "exercise")
        exercises.add(newExercise)
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
