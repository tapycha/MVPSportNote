//
//  ViewController.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 19.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import UIKit



protocol  HomeDisplayLogic: NSObjectProtocol {
    func setTable(model: HomeModel)
}


class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var addButton: UIView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var presenter: HomeBusinessLogic = HomePresenter()
    var data = HomeModel()
    var isEdit = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        addButton.layer.cornerRadius = addButton.frame.height/2
        data = presenter.loadData()
        emptyView.isHidden = data.workout.count>0
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
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
        data = presenter.AddWorkout()
       reload()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination =  segue.destination as? WorkoutViewController{
            destination.presenter.load(model: WorkoutModel( workout: data.workout[(tableView.indexPathForSelectedRow?.row)!]))
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        backItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backItem
    }
    func reload(){
        emptyView.isHidden = data.workout.count>0
        editButton.isEnabled = data.workout.count>0
        tableView.reloadData()
    }
}
extension HomeViewController:HomeDisplayLogic{
    func setTable(model: HomeModel) {
        
    }
}
extension HomeViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.workout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        cell.setupCell(index: indexPath.row, data: data.workout[indexPath.row],state: isEdit)
        cell.cellDelegate = self
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        data = presenter.SwapWorkout(source: sourceIndexPath.row, destination: destinationIndexPath.row)
        reload()
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "WorkoutSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension HomeViewController:HomeTableViewCellProtocol{
    func OnXClick(index: Int) {
        let DeleteAlert = UIAlertController(title: "Alert", message: "Are you sure you want to delete workout?\n You can`t udo this action", preferredStyle: UIAlertController.Style.alert)
        DeleteAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            self.data = self.presenter.DeleteWorkout(source: index)
            self.isEdit = self.data.workout.count != 0
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
        data = presenter.ChangeWorkoutName(source: index, newName: newName)
        reload()
    }
    
}
