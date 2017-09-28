//
//  ExerciseEditView.swift
//  Hercules
//
//  Created by Xiao Yan on 9/26/17.
//  Copyright © 2017 Class Pivot. All rights reserved.
//

import UIKit

class ExerciseEditView: UIView {
    
    let weightChangeArray: [Double] = [0.5, 1, 5, 10, -0.5, -1, -5, -10]
    let repsChangeArray: [Int] = [1, 5, 10, -1, -5, -10]
    var contentView = UIView()
    var valueLabel = UILabel()
    
    enum ValueType {
        case int32
        case double
    }
    
    var valueType: ValueType = .int32
    var weightValue: Double = 0
    var repsValue: Int = 0
    
    init<T>(frame: CGRect, value: T) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        if type(of: value) == Swift.Int32.self {
            valueType = .int32
            repsValue = Int(value as! Int32)
        } else {
            valueType = .double
            weightValue = value as! Double
        }
        contentViewInit()
        valueLabelInit(value: value)
        collectionViewInit()
        buttonsInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func contentViewInit() {
        contentView.backgroundColor = UIColor.white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentView)
        
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: device_width/2+140).isActive = true
    }
    
    func valueLabelInit<T>(value: T) {
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.textAlignment = .center
        valueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        valueLabel.backgroundColor = UIColor.white
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = "Current: \(value)"
        contentView.addSubview(valueLabel)
        
        valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        valueLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func collectionViewInit() {
        let collectionViewHeight = (device_width-40)/2
        let cellLayout = UICollectionViewFlowLayout()
        
        cellLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cellLayout.minimumInteritemSpacing = 0
        cellLayout.minimumLineSpacing = 0
        cellLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        if valueType == .int32 {
            cellLayout.itemSize = CGSize(width: (device_width-40)/3, height: collectionViewHeight/2)
        } else {
            cellLayout.itemSize = CGSize(width: (device_width-40)/4, height: collectionViewHeight/2)
        }
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 70, width: (device_width-40), height: collectionViewHeight), collectionViewLayout: cellLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.isScrollEnabled = false
        collectionView.register(ValueChangeCollectionViewCell.self, forCellWithReuseIdentifier: "ValueChangeCollectionViewCell")
        collectionView.bounces = false
        contentView.addSubview(collectionView)
    }
    
    func buttonsInit() {
        let buttonWidth = (device_width-40)/2-30
        let saveButton = UIButton(frame: CGRect(x: 20, y: (device_width-40)/2+90, width: buttonWidth, height: 40))
        saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        saveButton.setTitleColor(Constants.Colors.darkGray, for: UIControlState())
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        saveButton.layer.cornerRadius = 5
        saveButton.layer.borderColor = Constants.Colors.darkGray.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.addTarget(self, action: #selector(self.saveButtonClicked), for: UIControlEvents.touchUpInside)
        contentView.addSubview(saveButton)
        
        let cancelButton = UIButton(frame: CGRect(x: (device_width-40)/2+10, y: (device_width-40)/2+90, width: buttonWidth, height: 40))
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        cancelButton.setTitleColor(Constants.Colors.darkGray, for: UIControlState())
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.borderColor = Constants.Colors.darkGray.cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.addTarget(self, action: #selector(self.cancelButtonClicked), for: UIControlEvents.touchUpInside)
        contentView.addSubview(cancelButton)
    }
}

//MARK: - User Interactions
extension ExerciseEditView {
    func saveButtonClicked() {
    }
    
    func cancelButtonClicked() {
        self.removeFromSuperview()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ExerciseEditView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if valueType == .int32 {
            return 6
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ValueChangeCollectionViewCell", for: indexPath) as! ValueChangeCollectionViewCell
        switch valueType {
        case .int32:
            cell.valueLabel.text = indexPath.row <= 2 ? "+\(repsChangeArray[indexPath.row])" : "\(repsChangeArray[indexPath.row])"
        case .double:
            switch indexPath.row {
            case 0:
                cell.valueLabel.text = "+\(weightChangeArray[indexPath.row])"
            case 4:
                cell.valueLabel.text = "\(weightChangeArray[indexPath.row])"
            default:
                cell.valueLabel.text = indexPath.row <= 3 ? "+\(Int(weightChangeArray[indexPath.row]))" : "\(Int(weightChangeArray[indexPath.row]))"
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch valueType {
        case .int32:
            repsValue += repsChangeArray[indexPath.row]
            if repsValue < 0 || repsValue > 999 {
                repsValue = repsValue < 0 ? 0 : 999
            }
            valueLabel.text = "Current: \(repsValue)"
        case .double:
            weightValue += weightChangeArray[indexPath.row]
            if weightValue < 0 || weightValue > 999 {
                weightValue = weightValue < 0 ? 0 : 999
            }
            valueLabel.text = "Current: \(weightValue)"
        }
    }
}

class ValueChangeCollectionViewCell: UICollectionViewCell {
    
    var mainView: UIView!
    var imageView: UIImageView!
    var valueLabel: UILabel!
    var clicked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainView)
        
        imageView = UIImageView()
        imageView.image = UIImage(named: "circle_100x100")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(imageView)
        
        valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.textAlignment = .center
        valueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        valueLabel.textColor = Constants.Colors.darkGray
        mainView.addSubview(valueLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        //MARK: - Constraints
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        mainView.widthAnchor.constraint(equalTo: mainView.heightAnchor, constant: 0).isActive = true
        mainView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0).isActive = true
        
        valueLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        valueLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        valueLabel.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
