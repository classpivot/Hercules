//
//  NewPracticeVC.swift
//  Bloodhoof
//
//  Created by Xiao Yan on 7/24/17.
//  Copyright © 2017 Xiao Yan. All rights reserved.
//

import UIKit
import CoreData

class NewWorkoutVC: UIViewController {

    var workoutNameLabel: UILabel!
    var separatorBar: UIView!
    var startNewView: UIView!
    var exerciseTableView: UITableView!
    
    var workout: Workout?
    var sectionList: [Section]! = []
    var exerciseList: [Exercise]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarInit()
        startNewViewInit()
        workoutNameLabelInit()
        exerciseTableViewInit()

        CoreDataService.createWorkoutTemplateChest()
        CoreDataService.createWorkoutTemplateBS()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        workout = CoreDataService.getUnfinishedWorkoutData()
        if workout == nil {
            workoutNameLabel.isHidden = true
            exerciseTableView.isHidden = true
            separatorBar.isHidden = true
            startNewView.isHidden = false
        } else {
            workoutNameLabel.text = workout!.name
            exerciseTableView.reloadData()
            workoutNameLabel.isHidden = false
            exerciseTableView.isHidden = false
            separatorBar.isHidden = false
            startNewView.isHidden = true
        }
        
    }
    
    //MARK: UI Inits
    func navigationBarInit() {
        navigationItem.title = NSLocalizedString("Today", comment: "")
//        //navi left button
//        let img = UIImage(named: "menu")!.imageWithColor(UIColor.white)
//        menuButton = UIButton(type: .custom);
//        menuButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//        menuButton.setBackgroundImage(img, for: .normal)
//        menuButton.addTarget(self, action: #selector(self.didTapOpenButton(sender:)), for: .touchUpInside)
//        let naviLeftButton = UIBarButtonItem()
//        naviLeftButton.customView = menuButton
//        navigationItem.leftBarButtonItem = naviLeftButton
//        
//        //navi right button
//        helpButton = UIButton(type: .custom)
//        helpButton.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
//        helpButton.setTitle("Help", for: .normal)
//        helpButton.addTarget(self, action: #selector(self.didTapHelpButton(sender:)), for: .touchUpInside)
//        let naviRightButton = UIBarButtonItem()
//        naviRightButton.customView = helpButton
//        navigationItem.rightBarButtonItem = naviRightButton
    }
    
    func tabBarInit() {
        
    }
}

//MARK: - draw UI
extension NewWorkoutVC {
    fileprivate func workoutNameLabelInit() {
        workoutNameLabel = UILabel()
        workoutNameLabel.textAlignment = .center
        workoutNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        workoutNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(workoutNameLabel)
        
        separatorBar = UIView()
        separatorBar.backgroundColor = Constants.Colors.darkGray
        separatorBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(separatorBar)
        
        workoutNameLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        workoutNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        workoutNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        workoutNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        separatorBar.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 20).isActive = true
        separatorBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        separatorBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        separatorBar.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    //If no workout today, display this view
    fileprivate func startNewViewInit() {
        startNewView = UIView()
        startNewView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(startNewView)
        
        let reminderLabel = UILabel()
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        reminderLabel.textAlignment = .center
        reminderLabel.textColor = Constants.Colors.gray
        reminderLabel.numberOfLines = 0
        reminderLabel.text = NSLocalizedString("You don't have any plan for today yet. Let's start one!", comment: "")
        startNewView.addSubview(reminderLabel)
        
        //button click to create new workout for today
        let createNewButton = UIButton()
        createNewButton.setTitle(NSLocalizedString("Start", comment: ""), for: .normal)
        createNewButton.setTitleColor(Constants.Colors.darkGray, for: UIControlState())
        createNewButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        createNewButton.layer.cornerRadius = 5
        createNewButton.layer.borderColor = Constants.Colors.darkGray.cgColor
        createNewButton.layer.borderWidth = 1
        createNewButton.addTarget(self, action: #selector(self.createNewButtonClicked), for: UIControlEvents.touchUpInside)
        createNewButton.translatesAutoresizingMaskIntoConstraints = false
        startNewView.addSubview(createNewButton)
        
        startNewView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        startNewView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        startNewView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        startNewView.heightAnchor.constraint(equalToConstant: device_height/2).isActive = true

        reminderLabel.topAnchor.constraint(equalTo: startNewView.topAnchor, constant: 0).isActive = true
        reminderLabel.leadingAnchor.constraint(equalTo: startNewView.leadingAnchor, constant: 20).isActive = true
        reminderLabel.trailingAnchor.constraint(equalTo: startNewView.trailingAnchor, constant: -20).isActive = true
        reminderLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        createNewButton.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 50).isActive = true
        createNewButton.centerXAnchor.constraint(equalTo: startNewView.centerXAnchor, constant: 0).isActive = true
        createNewButton.widthAnchor.constraint(equalTo: startNewView.widthAnchor, multiplier: 0.6, constant: 0).isActive = true
        createNewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func exerciseTableViewInit() {
        exerciseTableView = UITableView()
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        exerciseTableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: ExerciseTableViewCell.identifier)
        exerciseTableView.register(AddExerciseTableViewCell.self, forCellReuseIdentifier: AddExerciseTableViewCell.identifier)
        exerciseTableView.backgroundColor = UIColor.white
        exerciseTableView.tableFooterView = UIView()
        exerciseTableView.separatorStyle = .none
        exerciseTableView.estimatedRowHeight = 200
        exerciseTableView.rowHeight = UITableViewAutomaticDimension
        exerciseTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(exerciseTableView)
        
        exerciseTableView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 30).isActive = true
        exerciseTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        exerciseTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        exerciseTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
    }
}

//MARK: - User Interactions
extension NewWorkoutVC {
    func createNewButtonClicked() {
        self.performSegue(withIdentifier: "NewWorkoutToWorkTypeSegue", sender: nil)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension NewWorkoutVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        //+1 is for one more section which only contains 1 cell "Add Section"
        print(workout!.section!.count+1)
        return workout == nil || workout!.section == nil ? 0 : workout!.section!.count+1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if workout != nil && workout!.section != nil && section < workout!.section!.count {
            return (workout!.section![section] as! Section).name
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if workout != nil && workout!.section != nil && section < workout!.section!.count {
            //+1 is for one more cell which is "Add Exercise"
            return (workout!.section![section] as! Section).exercise!.count+1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0..<sectionList.count: //normal cell
            if indexPath.row < (workout!.section![indexPath.section] as! Section).exercise!.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.identifier, for: indexPath) as! ExerciseTableViewCell
                cell.selectionStyle = .none
                let exercise = (workout!.section![indexPath.section] as! Section).exercise![indexPath.row] as! Exercise
                cell.nameLabel.text = exercise.name
                cell.weightTextField.text = "\(exercise.weight)"
                cell.weightTextField.text = "\(exercise.reps)"
                return cell
            } else { //add exercise cell
                let cell = tableView.dequeueReusableCell(withIdentifier: AddExerciseTableViewCell.identifier, for: indexPath) as! AddExerciseTableViewCell
                cell.selectionStyle = .none
                cell.nameLabel.text = NSLocalizedString("Add Exercise", comment: "")
                return cell
            }
        default: //add section cell
            let cell = tableView.dequeueReusableCell(withIdentifier: AddExerciseTableViewCell.identifier, for: indexPath) as! AddExerciseTableViewCell
            cell.selectionStyle = .none
            cell.nameLabel.text = NSLocalizedString("Add Section", comment: "")
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let section = sectionList[indexPath.section]
            let exercise = section.exercise![indexPath.row] as! Exercise
            CoreDataService.deleteExercise(exercise: exercise)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0..<sectionList.count: //add one more exercise in current section
            if indexPath.row == sectionList[indexPath.section].exercise!.count {
                print("add one exercise")
                //TODO: add new exercise
            }
        default: //add one more section
            print("add one section")
            //TODO: add new section
        }
    }
}
