//
//  CreateNewWorkoutVC.swift
//  Bloodhoof
//
//  Created by Xiao Yan on 8/4/17.
//  Copyright © 2017 Xiao Yan. All rights reserved.
//

import UIKit

class CreateNewWorkoutVC: UIViewController {

    var workoutNameTextField: UITextField!
    
    var exerciseTableView: UITableView!
    var workOut: Workout!
    var exerciseList: [Exercise]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutNameTextFieldInit()
        exerciseTableViewInit()
    }
}

//MARK: - draw UI
extension CreateNewWorkoutVC {
    fileprivate func workoutNameTextFieldInit() {
        workoutNameTextField = UITextField()
        workoutNameTextField.delegate = self
        workoutNameTextField.layer.borderWidth = 1
        workoutNameTextField.layer.borderColor = UIColor.black.cgColor
        workoutNameTextField.placeholder = NSLocalizedString("Workout Name", comment: "")
        workoutNameTextField.setLeftPaddingPoints(20)
        workoutNameTextField.clearButtonMode = .whileEditing
        workoutNameTextField.returnKeyType = .done
        workoutNameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(workoutNameTextField)
        
        workoutNameTextField.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        workoutNameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        workoutNameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        workoutNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func exerciseTableViewInit() {
        exerciseTableView = UITableView()
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        exerciseTableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: ExerciseTableViewCell.identifier)
        exerciseTableView.backgroundColor = UIColor.white
        exerciseTableView.tableFooterView = UIView()
        exerciseTableView.separatorStyle = .none
        exerciseTableView.estimatedRowHeight = 200
        exerciseTableView.rowHeight = UITableViewAutomaticDimension
        exerciseTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(exerciseTableView)
        
        exerciseTableView.topAnchor.constraint(equalTo: workoutNameTextField.bottomAnchor, constant: 30).isActive = true
        exerciseTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        exerciseTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        exerciseTableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 0).isActive = true
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CreateNewWorkoutVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.identifier, for: indexPath) as! ExerciseTableViewCell
        cell.selectionStyle = .none
//        cell.nameLabel.text = exerciseList[indexPath.row].name
        return cell
    }
}

//MARK: - UITextFieldDelegate
extension CreateNewWorkoutVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        workoutNameTextField.resignFirstResponder()
        return true
    }
}

//MARK: User Interactions
extension CreateNewWorkoutVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        workoutNameTextField.resignFirstResponder()
    }
}

//MARK: - MyPlansTableViewCell
class ExerciseTableViewCell: UITableViewCell {
    
    static let identifier = "ExerciseTableViewCell"
    
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
