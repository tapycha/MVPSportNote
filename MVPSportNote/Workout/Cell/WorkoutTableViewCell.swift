//
//  WorkoutTableViewCell.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 21.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import UIKit



class WorkoutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var backgroundImage: UIImageView!
    var data:Exersice = Exersice()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    func setupCell(index: Int,data: Exersice,state: Bool){
        self.data = data
        stackView.removeFullyAllArrangedSubviews()
        backgroundImage.backgroundColor = getColor()
        
        
        //stackView.alignment = .top
        //stackView.distribution = .equalSpacing
        stackView.spacing = 8.0
        
        
        
        stackView.addArrangedSubview(addTask())
        stackView.addArrangedSubview(addTask())
        stackView.addArrangedSubview(addTask())
        stackView.addArrangedSubview(addButton())
        
        
        /* let button1 = UIButton()
         button1.setTitle("btn 1", for: .normal)
         button1.backgroundColor = UIColor.red
         button1.translatesAutoresizingMaskIntoConstraints = false
         
         let button2 = UIButton()
         button2.setTitle("btn 2", for: .normal)
         button2.backgroundColor = UIColor.gray
         button2.translatesAutoresizingMaskIntoConstraints = false
         
         let button3 = UIButton()
         button3.setTitle("btn 3", for: .normal)
         button3.backgroundColor = UIColor.brown
         button3.translatesAutoresizingMaskIntoConstraints = false
         
         
         stackView.addArrangedSubview(button1)
         stackView.addArrangedSubview(button2)
         stackView.addArrangedSubview(button3)*/
        
    }
    private func addTask()-> UIView{
        let view = UIView()
        let labelDate = UILabel()
        labelDate.text = "Today"
        labelDate.textColor = UIColor.white
        labelDate.textAlignment  = .center
        view.addSubview(labelDate)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelDate.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        let labelDescription = UILabel()
        labelDescription.text = "0 x 0"
        labelDescription.textColor = UIColor.black
        labelDescription.textAlignment  = .center
        view.addSubview(labelDescription)
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelDescription.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: stackView.frame.height).isActive = true
        return view
    }
    
    private func addButton()-> UIView{
        let view = UIView()
        
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = getColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant:  30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.layer.cornerRadius = 15
        view.addSubview(button)
        //button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        return view
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


extension UIStackView {
    
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
    
}
