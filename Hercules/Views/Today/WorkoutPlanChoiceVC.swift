//
//  WorkoutPlanChoiceVC.swift
//  Bloodhoof
//
//  Created by Xiao Yan on 7/28/17.
//  Copyright © 2017 Xiao Yan. All rights reserved.
//

import UIKit
import CoreData

class WorkoutPlanChoiceVC: UIViewController {

    var myPlansTableView: UITableView!
    var addNewPlanButton: UIButton!
    
    var templatePlanButton: UIButton!
    
    var workoutList: [Workout] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPlansTableViewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWorkoutDataFromCoreData()
    }
}

//MARK: - draw UI
extension WorkoutPlanChoiceVC {
    fileprivate func myPlansTableViewInit() {
        myPlansTableView = UITableView()
        myPlansTableView.delegate = self
        myPlansTableView.dataSource = self
        myPlansTableView.register(MyPlansTableViewCell.self, forCellReuseIdentifier: "MyPlansTableViewCell")
        myPlansTableView.backgroundColor = UIColor.white
        myPlansTableView.tableFooterView = UIView()
        myPlansTableView.separatorStyle = .none
        myPlansTableView.estimatedRowHeight = 200
        myPlansTableView.rowHeight = UITableViewAutomaticDimension
        myPlansTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myPlansTableView)
        
        addNewPlanButton = UIButton()
        addNewPlanButton.setTitle(NSLocalizedString("Add a new plan", comment: ""), for: .normal)
        addNewPlanButton.setTitleColor(Constants.Colors.darkGray, for: .normal)
        addNewPlanButton.addTarget(self, action: #selector(self.createNewButtonClicked), for: UIControlEvents.touchUpInside)
        addNewPlanButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(addNewPlanButton)
        
        templatePlanButton = UIButton()
        templatePlanButton.setTitle(NSLocalizedString("Recommand a plan to me", comment: ""), for: .normal)
        templatePlanButton.setTitleColor(Constants.Colors.darkGray, for: .normal)
        templatePlanButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(templatePlanButton)
        
        myPlansTableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        myPlansTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        myPlansTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        
        addNewPlanButton.topAnchor.constraint(equalTo: myPlansTableView.bottomAnchor, constant: 30).isActive = true
        addNewPlanButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        addNewPlanButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        
        templatePlanButton.topAnchor.constraint(equalTo: addNewPlanButton.bottomAnchor, constant: 30).isActive = true
        templatePlanButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        templatePlanButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        templatePlanButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -30).isActive = true
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension WorkoutPlanChoiceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyPlansTableViewCell.identifier, for: indexPath) as! MyPlansTableViewCell
        cell.selectionStyle = .none
        cell.nameLabel.text = workoutList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            CoreDataService.deleteWorkout(workout: workoutList[indexPath.row])
            workoutList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

//MARK: - Button actions
extension WorkoutPlanChoiceVC {
    func createNewButtonClicked() {
        self.performSegue(withIdentifier: "createNewWorkoutSegue", sender: nil)
    }
}

//MARK: - helper functions
extension WorkoutPlanChoiceVC {
    //TO DO: move to presenter later
    func fetchWorkoutDataFromCoreData() {
        workoutList = CoreDataService.getMyWorkoutPlan()
        myPlansTableView.reloadData()
    }
}

//MARK: - MyPlansTableViewCell
class MyPlansTableViewCell: UITableViewCell {
    
    static let identifier = "MyPlansTableViewCell"
    
    var mainView: UIView!
    var nameLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.layer.cornerRadius = 3
        mainView.layer.borderWidth = 2
        contentView.addSubview(mainView)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = Constants.Colors.darkGray
        mainView.addSubview(nameLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        //MARK: - Constraints
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
