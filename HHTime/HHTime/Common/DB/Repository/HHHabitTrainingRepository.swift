//
//  HHHabitTrainingRepository.swift
//  HHTime
//
//  Created by tianxi on 2019/12/4.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation

internal struct HHHabitTrainingRepository {
    
    /// 已选择了习惯才能新建习惯
    static func insert(_ habitTraining:HHHabitTrainingBean) {
        // bean -> entity
        
        guard let habit = habitTraining.habit,
            let habitId = habit.id else { return  }
        
        let habitTrainingEntity = HHHabitTrainingResult.init()
        habitTrainingEntity.id = habitTraining.id;
        habitTrainingEntity.habitId = habitId
        habitTrainingEntity.alarms = habitTraining.alarms;
        habitTrainingEntity.remindFrequencyType = habitTraining.remindFrequencyType;
        habitTrainingEntity.weekDays = habitTraining.weekDays;
        habitTrainingEntity.encouragingSayings = habitTraining.encouragingSayings;
        habitTrainingEntity.createDate = habitTraining.createDate;
        habitTrainingEntity.signedDays = habitTraining.signedDays;
         
        HHSQLiteManager.shared.getHabitTrainingDao().insert(bean: habitTrainingEntity) { (success) in
             
        }
    }
    
    // MARK: Transaction
    
    /// 习惯和新建习惯同时进行
    static func insertAll(_ habitTraining:HHHabitTrainingBean) {
        // bean -> entity
        
        guard let habit = habitTraining.habit,
            let habitId = habit.id else { return  }
        
        let habitEntity = HHHabitResult.init()
        habitEntity.id = habitId
        habitEntity.type = habitTraining.habit?.type
        habitEntity.title = habitTraining.habit?.title
        habitEntity.icon = habitTraining.habit?.icon
        habitEntity.bgColor = habitTraining.habit?.bgColor
        
        let habitTrainingEntity = HHHabitTrainingResult.init()
        habitTrainingEntity.id = habitTraining.id;
        habitTrainingEntity.habitId = habitId
        habitTrainingEntity.alarms = habitTraining.alarms;
        habitTrainingEntity.remindFrequencyType = habitTraining.remindFrequencyType;
        habitTrainingEntity.weekDays = habitTraining.weekDays;
        habitTrainingEntity.encouragingSayings = habitTraining.encouragingSayings;
        habitTrainingEntity.createDate = habitTraining.createDate;
        habitTrainingEntity.signedDays = habitTraining.signedDays;
         
        HHSQLiteManager.shared.getDBQueue()?.inTransaction({ (db, rollback) in
            var successAll = true
            
            HHSQLiteManager.shared.getHabitDao().insert(bean: habitEntity) { (success) in
                if !success {
                    successAll = false
                }
            }
            
            //读取刚插入的记录的ID
            //select last_insert_rowid() from 表名
            HHSQLiteManager.shared.getHabitDao().getLastInsertRowid { (lastId) in
                if lastId <= 0 {
                    successAll = false
                }
                habitTrainingEntity.habitId = lastId
            }
            
            HHSQLiteManager.shared.getHabitTrainingDao().insert(bean: habitTrainingEntity) { (success) in
                if !success {
                    successAll = false
                }
            }
             
            if !successAll {
                db.rollback()
            }
        })
    }
    
    static func query(_ id:Int,_ complete: (HHHabitTrainingBean?) -> Void) {
        HHSQLiteManager.shared.getDBQueue()?.inTransaction({ (db, rollback) in
            HHSQLiteManager.shared.getHabitTrainingDao().query(id: id) { (habitTraining) in
                guard let habitTraining = habitTraining,
                    let habitId = habitTraining.habitId else {
                    complete(nil)
                    return
                }
                let bean = HHHabitTrainingBean.init()
                bean.id = habitTraining.id;
                bean.alarms = habitTraining.alarms;
                bean.remindFrequencyType = habitTraining.remindFrequencyType;
                bean.weekDays = habitTraining.weekDays;
                bean.encouragingSayings = habitTraining.encouragingSayings;
                bean.createDate = habitTraining.createDate;
                bean.signedDays = habitTraining.signedDays;
                 
                HHSQLiteManager.shared.getHabitDao().query(id: habitId) { (habit) in
                    guard let habit = habit else {
                        complete(nil)
                        return
                    }

                    let habitBean = HHHabitBean.init()
                    habitBean.id = habit.id
                    habitBean.type = habit.type
                    habitBean.title = habit.title
                    habitBean.icon = habit.icon
                    habitBean.bgColor = habit.bgColor
 
                    bean.habit = habitBean
                    complete(bean)
                }
            }
        })
    }
}
