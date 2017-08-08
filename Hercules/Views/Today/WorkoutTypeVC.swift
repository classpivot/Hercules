//
//  WorkoutTypeVC.swift
//  Bloodhoof
//
//  Created by Xiao Yan on 7/26/17.
//  Copyright © 2017 Xiao Yan. All rights reserved.
//

import UIKit

class WorkoutTypeVC: UIViewController {

    var bodyPartsCollectionView: UICollectionView!
    var checkedList = [Bool](repeatElement(false, count: Constants.bodyParts.count))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyPartsCollectionViewInit()
        nextStepButtonInit()
    }
}

//MARK: - draw UI
extension WorkoutTypeVC {
    //MARK: - body parts colloction view ui
    fileprivate func bodyPartsCollectionViewInit() {
        let collectionViewHeight = device_height-navi_height-tabbar_height-30-150
        let cellLayout = UICollectionViewFlowLayout()
        cellLayout.itemSize = CGSize(width: device_width/2, height: collectionViewHeight/4)
        cellLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cellLayout.minimumInteritemSpacing = 0
        cellLayout.minimumLineSpacing = 0
        cellLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        bodyPartsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 30, width: device_width, height: collectionViewHeight), collectionViewLayout: cellLayout)
        bodyPartsCollectionView.delegate = self
        bodyPartsCollectionView.dataSource = self
        bodyPartsCollectionView.showsVerticalScrollIndicator = false
        bodyPartsCollectionView.showsHorizontalScrollIndicator = false
        bodyPartsCollectionView.backgroundColor = UIColor.clear
        bodyPartsCollectionView.isScrollEnabled = false
        bodyPartsCollectionView.register(BodyPartsCollectionViewCell.self, forCellWithReuseIdentifier: "BodyPartsCollectionViewCell")
        bodyPartsCollectionView.bounces = false
        self.view.addSubview(bodyPartsCollectionView)
    }
    
    fileprivate func nextStepButtonInit() {
        let nextStepButton = UIButton()
        nextStepButton.setTitle(NSLocalizedString("Next", comment: ""), for: .normal)
        nextStepButton.setTitleColor(Constants.Colors.darkGray, for: UIControlState())
        nextStepButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        nextStepButton.layer.cornerRadius = 5
        nextStepButton.layer.borderColor = Constants.Colors.darkGray.cgColor
        nextStepButton.layer.borderWidth = 1
        nextStepButton.addTarget(self, action: #selector(self.nextStepButtonClicked), for: UIControlEvents.touchUpInside)
        nextStepButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(nextStepButton)
        
        nextStepButton.topAnchor.constraint(equalTo: bodyPartsCollectionView.bottomAnchor, constant: 50).isActive = true
        nextStepButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        nextStepButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6, constant: 0).isActive = true
        nextStepButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

//MARK: - Button actions
extension WorkoutTypeVC {
    func nextStepButtonClicked() {
        self.performSegue(withIdentifier: "workoutPlanChoiceSegue", sender: nil)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension WorkoutTypeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.bodyParts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BodyPartsCollectionViewCell", for: indexPath) as! BodyPartsCollectionViewCell
        cell.nameLabel.text = Constants.bodyParts[indexPath.row]
        if checkedList[indexPath.row] {
            cell.checkImageView.image = UIImage(named: "markdone_filled_50x50")
            cell.mainView.layer.borderColor = Constants.Colors.green.cgColor
        } else {
            cell.checkImageView.image = UIImage(named: "markdone_50x50")
            cell.mainView.layer.borderColor = Constants.Colors.gray.cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkedList[indexPath.row] = !checkedList[indexPath.row]
        collectionView.reloadData()
    }
}

class BodyPartsCollectionViewCell: UICollectionViewCell {
    
    var mainView: UIView!
    var checkImageView: UIImageView!
    var nameLabel: UILabel!
    var clicked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.layer.cornerRadius = 3
        mainView.layer.borderWidth = 2
        contentView.addSubview(mainView)
        
        checkImageView = UIImageView()
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(checkImageView)
        
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
        
        checkImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        checkImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        checkImageView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.15).isActive = true
        checkImageView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.15).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
