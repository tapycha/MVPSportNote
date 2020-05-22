//
//  WorkoutHeaderTableViewCell.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 21.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import UIKit

class WorkoutHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var circleImage: UIImageView!

       @IBOutlet weak var workoutHeaderLabel: UILabel!
       @IBOutlet weak var workoutLabel: UILabel!
       
       @IBOutlet weak var indexButton: UIButton!
       @IBOutlet weak var topSeparator: UIImageView!
       @IBOutlet weak var bottomSeparator: UIImageView!
       
       var data:Exersice = Exersice()
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

       
       func setupCell(index: Int,data: Exersice,state: Bool){
           self.data = data
        indexButton.setTitle(String(data.id), for: .normal)
           circleImage.tintColor = getColor()
           workoutHeaderLabel.textColor = getColor()
           workoutHeaderLabel.text = data.title
        workoutLabel.text = "\(data.getMinUnit1()) - \(data.getMaxUnit1()) \(data.unit1)  \(data.getMinUnit2()) - \(data.getMaxUnit2()) \(data.unit2)  0 - 0 подх"
           changeCell(isEdit: state)
           topSeparator.isHidden = data.id != 1
       }
       func changeCell(isEdit: Bool){
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
