//
//  HomePresenter.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 20.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import Foundation

protocol WorkoutBusinessLogic {
    func load(model: WorkoutModel)
    func loadNewExercose(title: String, index: Int)
    func getTitle()->String
    func getData()->WorkoutModel
    func SwapExersice(source: Int,destination: Int) -> WorkoutModel
    func DeleteExersice(source: Int) -> WorkoutModel
}
class WorkoutPresenter: WorkoutBusinessLogic {
    
    
    var view :WorkoutDisplayLogic?
    var data: WorkoutModel = WorkoutModel()
    init() {
    }
    
    func load(model: WorkoutModel) {
        data = model
    }
    func loadNewExercose(title: String, index: Int) {
        print("asdasdsd")
        let unit1 =  ["km", "kg"]
        let unit2 =  ["min","times"]
        var temp = Exersice();
        temp.id = data.workout.exersice.count+1
        temp.title = title
        temp.unit1 = unit1[index]
        temp.unit2 = unit2[index]
        data.workout.exersice.append(temp)
    }
    func getTitle()->String {
        return data.workout.name 
    }
    func getData()->WorkoutModel
    {
        return data
    }
    func SwapExersice(source: Int,destination: Int) -> WorkoutModel {
        let workoutMove = data.workout.exersice[source]
        data.workout.exersice.insert(workoutMove, at:source<destination ? destination + 1 :  destination)
        data.workout.exersice.remove(at: source>destination ? source + 1 : source)
        
        for i in 0...data.workout.exersice.count-1
        {
            data.workout.exersice[i].id = i+1
        }
        return data
        
    }
    func DeleteExersice(source: Int) -> WorkoutModel {
        data.workout.exersice.remove(at: source)
        if data.workout.exersice.count>0 {
            for i in 0...data.workout.exersice.count-1
            {
                data.workout.exersice[i].id = i+1
            }
        }
        return data
    }
}
