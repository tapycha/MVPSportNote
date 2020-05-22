//
//  HomeModel.swift
//  MVPSportNote
//
//  Created by Andrew Peneznyk on 19.05.2020.
//  Copyright © 2020 Andrew Penzenyk. All rights reserved.
//

import Foundation

class Workout {
    var id: Int = 0
    var name: String = ""
    var exersice:[Exersice] = []
}
class Exersice {
    var id: Int = 0
    var isOpen = Bool()
    var title = String()
    var unit1 = String()
    var unit2 = String()
    var task : [DailyTask] = []
    
    func getMinUnit1()->Int{
        var minUnit1 = 0
        if task.count == 0
        {
            return 0
        }
        for i in 0...task.count
        {
            if( task[i].values.count == 0)
            {
                return 0
            }
            for j in 0...task[i].values.count
            {
                if minUnit1 == 0 || minUnit1 > task[i].values[j].value1
                {
                    minUnit1 = task[i].values[j].value1
                }
            }
        }
        return minUnit1
    }
    func getMaxUnit1()->Int{
        var maxUnit1 = 0
        if task.count == 0
        {
            return 0
        }
        for i in 0...task.count
        {
            if( task[i].values.count == 0)
            {
                return 0
            }
            for j in 0...task[i].values.count
            {
                if  maxUnit1 < task[i].values[j].value1
                {
                    maxUnit1 = task[i].values[j].value1
                }
            }
        }
        return maxUnit1
    }
    func getMinUnit2()->Int{
        var minUnit2 = 0
        if task.count == 0
        {
            return 0
        }
        for i in 0...task.count
        {
            if( task[i].values.count == 0)
            {
                return 0
            }
            for j in 0...task[i].values.count
            {
                if minUnit2 == 0 || minUnit2 > task[i].values[j].value2
                {
                    minUnit2 = task[i].values[j].value2
                }
            }
        }
        return minUnit2
    }
    func getMaxUnit2()->Int{
        var maxUnit2 = 0
        if task.count == 0
        {
            return 0
        }
        for i in 0...task.count
        {
            if( task[i].values.count == 0)
            {
                return 0
            }
            for j in 0...task[i].values.count
            {
                if  maxUnit2 < task[i].values[j].value2
                {
                    maxUnit2 = task[i].values[j].value2
                }
            }
        }
        return maxUnit2
    }
    
}
class DailyTask {
    var date = String()
    var values: [IndividualTask] = []
}
class IndividualTask {
    var value1 = Int()
    var value2 = Int()
    
}
class HomeModel {
    var workout: [Workout] = []
}
