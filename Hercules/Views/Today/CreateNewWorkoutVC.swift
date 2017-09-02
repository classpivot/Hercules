//
//  CreateNewWorkoutVC.swift
//  Bloodhoof
//
//  Created by Xiao Yan on 8/4/17.
//  Copyright © 2017 Xiao Yan. All rights reserved.
//

import UIKit
import CoreData

class CreateNewWorkoutVC: UIViewController {

    var workoutNameTextField: UITextField!
    
    var exerciseTableView: UITableView!
    var workout: Workout!
    var sectionList: [Section]! = []
    var exerciseList: [Exercise]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if workout == nil {
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let workoutEntity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
            workout = Workout(entity: workoutEntity!, insertInto: managedContext)
        } else {
            if let sections = workout.section {
                for section in sections {
                    sectionList.append(section as! Section)
                }
//                sectionList = sectionList.sorted(by: {$0.index < $1.index})
            }
        }
        navigationBarInit()
        workoutNameTextFieldInit()
        exerciseTableViewInit()
//        startButtonInit()
    }
    
    deinit {
        print("CreateNewWorkoutVC is destroyed.")
    }
}

//MARK: - draw UI
extension CreateNewWorkoutVC {
    fileprivate func navigationBarInit() {
//        navigationItem.title = NSLocalizedString("Today", comment: "")
        //        //navi left button
        //        let img = UIImage(named: "menu")!.imageWithColor(UIColor.white)
        //        menuButton = UIButton(type: .custom);
        //        menuButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        //        menuButton.setBackgroundImage(img, for: .normal)
        //        menuButton.addTarget(self, action: #selector(self.didTapOpenButton(sender:)), for: .touchUpInside)
        //        let naviLeftButton = UIBarButtonItem()
        //        naviLeftButton.customView = menuButton
        //        navigationItem.leftBarButtonItem = naviLeftButton

        //navi right button
        let saveButton = UIButton(type: .custom)
        saveButton.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(self.saveButtonClicked), for: .touchUpInside)
        let naviRightButton = UIBarButtonItem()
        naviRightButton.customView = saveButton
        navigationItem.rightBarButtonItem = naviRightButton
    }
    
    fileprivate func workoutNameTextFieldInit() {
        workoutNameTextField = UITextField()
        workoutNameTextField.delegate = self
        workoutNameTextField.layer.borderWidth = 1
        workoutNameTextField.layer.borderColor = UIColor.black.cgColor
        workoutNameTextField.placeholder = NSLocalizedString("Workout Name", comment: "")
        workoutNameTextField.text = workout.name
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
        exerciseTableView.register(AddExerciseTableViewCell.self, forCellReuseIdentifier: AddExerciseTableViewCell.identifier)
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
        exerciseTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
    }
    
//    fileprivate func startButtonInit() {
//        let startButton = UIButton()
//        startButton.setTitle(NSLocalizedString("Start", comment: ""), for: .normal)
//        startButton.setTitleColor(Constants.Colors.darkGray, for: UIControlState())
//        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
//        startButton.layer.cornerRadius = 5
//        startButton.layer.borderColor = Constants.Colors.darkGray.cgColor
//        startButton.layer.borderWidth = 1
//        startButton.addTarget(self, action: #selector(self.createButtonClicked), for: UIControlEvents.touchUpInside)
//        startButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(startButton)
//        
//        startButton.topAnchor.constraint(equalTo: exerciseTableView.bottomAnchor, constant: 20).isActive = true
//        startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
//        startButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6, constant: 0).isActive = true
//        startButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
//        startButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CreateNewWorkoutVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        //+1 is for one more section which only contains 1 cell "Add Section"
        return sectionList.count+1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sectionList.count {
            return sectionList[section].name
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < sectionList.count {
            //+1 is for one more cell which is "Add Exercise"
            return sectionList[section].exercise!.count+1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0..<sectionList.count: //normal cell
            if indexPath.row < sectionList[indexPath.section].exercise!.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.identifier, for: indexPath) as! ExerciseTableViewCell
                cell.selectionStyle = .none
                let exercise = (workout.section![indexPath.section] as! Section).exercise![indexPath.row] as! Exercise
                cell.nameLabel.text = exercise.name
                exercise.reps = 10
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
            }
        default: //add one more section
            print("add one section")
        }
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
    
    func saveButtonClicked() {
        print("Save")
        do {
            print(((workout.section![0] as! Section).exercise![0] as! Exercise).reps)
            try workout.managedObjectContext?.save()
            self.navigationController?.popToRootViewController(animated: true)
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
}

//MARK: - MyPlansTableViewCell
class ExerciseTableViewCell: UITableViewCell {
    
    static let identifier = "ExerciseTableViewCell"
    
    var mainView: UIView!
    var nameLabel: UILabel!
    var weightLabel: UILabel!
    var weightTextField: UITextField!
    var repsLabel: UILabel!
    var repsTextField: UITextField!
    
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
        
        weightLabel = UILabel()
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.adjustsFontSizeToFitWidth = true
        weightLabel.font = UIFont.boldSystemFont(ofSize: 17)
        weightLabel.textColor = Constants.Colors.darkGray
        weightLabel.text = "lbs: "
        mainView.addSubview(weightLabel)
        
        weightTextField = UITextField()
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.text = "0"
        weightTextField.textAlignment = .center
        weightTextField.layer.borderColor = Constants.Colors.gray.cgColor
        weightTextField.layer.borderWidth = 1
        mainView.addSubview(weightTextField)
        
        repsLabel = UILabel()
        repsLabel.translatesAutoresizingMaskIntoConstraints = false
        repsLabel.adjustsFontSizeToFitWidth = true
        repsLabel.font = UIFont.boldSystemFont(ofSize: 17)
        repsLabel.textColor = Constants.Colors.darkGray
        repsLabel.text = "reps: "
        mainView.addSubview(repsLabel)
        
        repsTextField = UITextField()
        repsTextField.translatesAutoresizingMaskIntoConstraints = false
        repsTextField.text = "0"
        repsTextField.textAlignment = .center
        repsTextField.layer.borderColor = Constants.Colors.gray.cgColor
        repsTextField.layer.borderWidth = 1
        mainView.addSubview(repsTextField)
        
        setConstraints()
    }
    
    func setConstraints() {
        //MARK: - Constraints
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5).isActive = true
        
        weightLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        weightLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20).isActive = true
        weightLabel.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5).isActive = true
        
        weightTextField.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5).isActive = true
        weightTextField.leadingAnchor.constraint(equalTo: weightLabel.trailingAnchor, constant: 0).isActive = true
        weightTextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        weightTextField.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5, constant: -10).isActive = true
        
        repsLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        repsLabel.leadingAnchor.constraint(equalTo: weightTextField.trailingAnchor, constant: 50).isActive = true
        repsLabel.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5).isActive = true
        
        repsTextField.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5).isActive = true
        repsTextField.leadingAnchor.constraint(equalTo: repsLabel.trailingAnchor, constant: 0).isActive = true
        repsTextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        repsTextField.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - MyPlansTableViewCell
class AddExerciseTableViewCell: UITableViewCell {
    
    static let identifier = "AddExerciseTableViewCell"
    
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
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.textAlignment = .center
        nameLabel.textColor = Constants.Colors.red
        mainView.addSubview(nameLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        //MARK: - Constraints
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
