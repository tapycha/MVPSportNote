//
//  HomeTableViewCell.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 20.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import UIKit

protocol HomeTableViewCellProtocol {
    func OnXClick(index: Int)
    func NameChanged(index: Int,newName: String)
}


class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var circleImage: UIImageView!
    @IBOutlet weak var workoutTextField: UITextField!
    @IBOutlet weak var workoutLabel: UILabel!
    
    @IBOutlet weak var indexButton: UIButton!
    @IBOutlet weak var topSeparator: UIImageView!
    @IBOutlet weak var bottomSeparator: UIImageView!
    
    var data:Workout = Workout()
    var cellDelegate: HomeTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func DeleteButton(_ sender: Any) {
        cellDelegate?.OnXClick(index: data.id-1)
    }
    @IBAction func NameChanged(_ sender: Any) {
        cellDelegate?.NameChanged(index: data.id-1,newName: workoutTextField.text ?? "")
    }
    
    func setupCell(index: Int,data: Workout,state: Bool){
        self.data = data
        indexButton.setTitle(String(data.id), for: .normal)
        workoutTextField.isUserInteractionEnabled = false
        circleImage.tintColor = getColor()
        workoutTextField.textColor = getColor()
        workoutTextField.text = data.name
        changeCell(isEdit: state)
        topSeparator.isHidden = data.id != 1
        //TODO next line don`t 	work
        workoutLabel.text = data.exersice.count == 0 ? "No workouts yet": "Today"
    }
    func changeCell(isEdit: Bool){
        workoutTextField.isUserInteractionEnabled = isEdit
        workoutLabel.isHidden = isEdit
        indexButton.setTitle(isEdit ?  "X" : String(data.id), for: .normal)
        circleImage.tintColor = isEdit ? UIColor.red : getColor()
        indexButton.setTitleColor(isEdit ? UIColor.red : getColor(), for: .normal)
    }
    private func getColor()->UIColor{
        var color: UIColor
        switch (data.id-1) % 3 {
        case 0:
            color = UIColor.systemBlue
        case 1:
            color = UIColor.red
        case 2:
            color = UIColor.green
        default:
            color = UIColor.systemBlue
        }
        return color
    }
}
