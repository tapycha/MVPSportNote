//
//  NewUnitViewController.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 21.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import UIKit

protocol NewUnitDisplayLogic {
    func getNewExercise(title: String, index: Int)
}

class NewUnitViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    @IBOutlet weak var titileField: UITextField!
    @IBOutlet weak var unitField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var selectedField :String?
    let array:[String] = [ "Distance (km) / Time (min)", "Weight (kg) / Reps (times)"]
    var index = 0
    var delegate: NewUnitDisplayLogic?
    override func viewDidLoad() {
        super.viewDidLoad()
        titileField.text = selectedField
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = CGColor.init(srgbRed: 0, green: 0, blue: 1, alpha: 1)
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        unitField.inputView = pickerView
        unitField.text = array[index]
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        self.delegate?.getNewExercise(title: selectedField!, index: index)
        let tempviewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(tempviewControllers[tempviewControllers.count - 3], animated: true)
        
        /*  if let vc = viewControllers.filter({$0.isKind(of: WorkoutViewController)}).last {
         popToViewController(vc, animated: true)
         }*/
        
        //  performSegue(withIdentifier: "WorkoutSegue", sender: self)
        print("kurva")
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        unitField.text = array[row]
        index = row
    }
    
}
