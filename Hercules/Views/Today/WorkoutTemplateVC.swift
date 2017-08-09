//
//  WorkoutTemplateVC.swift
//  Hercules
//
//  Created by Xiao Yan on 8/9/17.
//  Copyright © 2017 Class Pivot. All rights reserved.
//

import UIKit

class WorkoutTemplateVC: UIViewController {
    
    var templatesTableView: UITableView!
    var workoutList: [Workout] = CoreDataService.getWorkoutTemplates()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        templatesTableViewInit()

    }
}

//MARK: - draw UI
extension WorkoutTemplateVC {
    fileprivate func templatesTableViewInit() {
        templatesTableView = UITableView()
        templatesTableView.delegate = self
        templatesTableView.dataSource = self
        templatesTableView.register(MyPlansTableViewCell.self, forCellReuseIdentifier: "MyPlansTableViewCell")
        templatesTableView.backgroundColor = UIColor.white
        templatesTableView.tableFooterView = UIView()
        templatesTableView.separatorStyle = .none
        templatesTableView.estimatedRowHeight = 200
        templatesTableView.rowHeight = UITableViewAutomaticDimension
        templatesTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(templatesTableView)
        
        templatesTableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        templatesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        templatesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        templatesTableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0).isActive = true
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension WorkoutTemplateVC: UITableViewDelegate, UITableViewDataSource {
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
