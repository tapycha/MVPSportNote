//
//  HomePresenter.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 19.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import Foundation

protocol HomeBusinessLogic {
    func loadData()->HomeModel
    func loadWorkout(data: WorkoutModel)
    func AddWorkout()-> HomeModel
    func SwapWorkout(source: Int,destination: Int) -> HomeModel
    func DeleteWorkout(source: Int) -> HomeModel
    func ChangeWorkoutName(source: Int, newName: String) -> HomeModel
}
class HomePresenter: HomeBusinessLogic {
    var view :HomeDisplayLogic?
    var data: HomeModel = HomeModel()
    init() {
    }

    func AddWorkout() ->HomeModel {
        var temp = Workout();
        temp.id = data.workout.count+1
        temp.name = "Workout \(temp.id)"
        data.workout.append(temp)
        return data
    }
    func loadData()->HomeModel {
        //load from core data
        return data
    }
    func loadWorkout(data: WorkoutModel) {
        self.data.workout[data.workout.id] = data.workout
    }
    func SwapWorkout(source: Int,destination: Int) -> HomeModel {
          let workoutMove = data.workout[source]

            data.workout.insert(workoutMove, at:source<destination ? destination + 1 :  destination)
            data.workout.remove(at: source>destination ? source + 1 : source)

        for i in 0...data.workout.count-1
        {
            data.workout[i].id = i+1
        }
        return data
        
    }
    func DeleteWorkout(source: Int) -> HomeModel {
         data.workout.remove(at: source)
        if data.workout.count>0 {
        for i in 0...data.workout.count-1
        {
            data.workout[i].id = i+1
        }
        }
        return data
    }
    func ChangeWorkoutName(source: Int,newName: String) -> HomeModel {
        data.workout[source].name = newName
        return data
    }
}
