//
//  NewWorkoutPresenter.swift
//  Hercules
//
//  Created by Xiao Yan on 9/24/17.
//  Copyright © 2017 Class Pivot. All rights reserved.
//

import Foundation

class NewWorkoutPresenter {
    private let coreDataService: CoreDataService
    weak private var delegate: NewWorkoutDelegate?
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
}

protocol NewWorkoutDelegate: class {
    func setCurrentWorkoutPlan()
}
