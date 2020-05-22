//
//  WorkoutModel.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 20.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import Foundation

class WorkoutModel {
    var workout:Workout = Workout()
    
    init(workout: Workout)
    {
        self.workout = workout
    }
    init()
    {
        self.workout = Workout()
    }
}
