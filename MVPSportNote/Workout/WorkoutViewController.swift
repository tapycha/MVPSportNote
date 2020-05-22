//
//  WorkoutViewController.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 20.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import UIKit

protocol  WorkoutDisplayLogic: NSObjectProtocol {
    
}


class WorkoutViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var addButton: UIView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var presenter: WorkoutBusinessLogic = WorkoutPresenter()
    var data: WorkoutModel = WorkoutModel()
    var isEdit = false;
    var previousExpand = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = presenter.getTitle()
        tableView?.dataSource = self
        tableView?.delegate = self
        data =  presenter.getData()
        addButton.layer.cornerRadius = addButton.frame.height/2
        emptyView.isHidden = data.workout.exersice.count>0
        tableView.register(UINib(nibName: "WorkoutHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "WorkoutHeaderTableViewCell")
        tableView.register(UINib(nibName: "WorkoutTableViewCell", bundle: nil), forCellReuseIdentifier: "WorkoutTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        reload()
    }
    @IBAction func EditTapped(_ sender: Any) {
        isEdit = !isEdit
        editButton.image =  UIImage(systemName: isEdit ?"checkmark.circle": "pencil.circle")
        addButton.isHidden = isEdit
        tableView.setEditing(isEdit, animated: true)
        tableView.reloadData()
    }
    
    @IBAction func AddTapped(_ sender: Any) {
        //data = presenter.AddExersice()
       // reload()
              performSegue(withIdentifier: "NewExerciseSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination =  segue.destination as? NewExerciseViewController{

                   destination.delegate = self

               }
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backItem
    }
    func reload(){
        emptyView.isHidden = data.workout.exersice.count>0
        editButton.isEnabled = data.workout.exersice.count>0
        tableView.reloadData()
    }
    
}
extension WorkoutViewController: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.workout.exersice[section].isOpen  {
            return 2// data.workout.exersice[section].task.count
        }
        else
        {
            return 1
        }
        //return  2//data.workout.exersice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutHeaderTableViewCell", for: indexPath) as! WorkoutHeaderTableViewCell
            cell.setupCell(index: indexPath.section, data: data.workout.exersice[indexPath.section],state: isEdit)
            cell.cellDelegate = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableViewCell", for: indexPath) as! WorkoutTableViewCell
            cell.setupCell(index: indexPath.section, data: data.workout.exersice[indexPath.section],state: isEdit)
            return cell
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.workout.exersice.count
        //return 2
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        data = presenter.SwapExersice(source: sourceIndexPath.row, destination: destinationIndexPath.row)
        reload()
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

           if previousExpand != -1 && previousExpand != indexPath.section
           {
                data.workout.exersice[previousExpand].isOpen = false
                let sections1 = IndexSet.init(integer: previousExpand)
                tableView.reloadSections(sections1, with: .none)
           }
        
        data.workout.exersice[indexPath.section].isOpen = !data.workout.exersice[indexPath.section].isOpen
        let sections = IndexSet.init(integer: indexPath.section)
        tableView.reloadSections(sections, with: .none)
        previousExpand = indexPath.section
        // tableView.deselectRow(at: indexPath, animated: true)
        //  performSegue(withIdentifier: "WorkoutSegue", sender: self)
    }
    
}
extension WorkoutViewController:HomeTableViewCellProtocol{
    func OnXClick(index: Int) {
        let DeleteAlert = UIAlertController(title: "Alert", message: "Are you sure you want to delete workout?\n You can`t udo this action", preferredStyle: UIAlertController.Style.alert)
        DeleteAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            self.data = self.presenter.DeleteExersice(source: index)
            self.isEdit = self.data.workout.exersice.count != 0
            self.editButton.image =  UIImage(systemName: self.isEdit ?"checkmark.circle": "pencil.circle")
            self.addButton.isHidden = self.isEdit
            self.tableView.setEditing(self.isEdit, animated: true)
            self.tableView.reloadData()
            self.reload()
        }))
        
        DeleteAlert.addAction(UIAlertAction(title: "Cancel",style: .cancel, handler: { (action: UIAlertAction!) in
            //if anything to do after cancel clicked
        }))
        present(DeleteAlert, animated: true, completion: nil)
        
    }
    func NameChanged(index: Int, newName: String){
        
    }
    
}
extension WorkoutViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? HomeViewController)?.presenter.loadWorkout(data: data)
    }
}
extension WorkoutViewController: NewUnitDisplayLogic {
    func getNewExercise(title: String, index: Int) {
        presenter.loadNewExercose(title: title, index: index)
        reload()
    }
    
    
}
