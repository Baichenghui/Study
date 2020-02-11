//
//  HHDaysMatterTable.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/2.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
import FMDB

struct HHHabitTrainingDao {
    
    private var dbQueue: FMDatabaseQueue?
    public init?(queue: FMDatabaseQueue?){
        self.dbQueue = queue
    }
    /*
     var id: Int?
     /// 习惯id，对应HHHabitResult 中的id
     var habitId: Int = 0
     /// 提醒日的闹钟，每个提醒日有效性一样。（只能设置24小时时间，不能设置日期）
     var alarms:[String]?
     ///  1、每月几次
     ///  2、每周几次     周日-周六 提供选择 [0，1，2，3，4，5，6]
     ///  3、每日几次
     var remindFrequencyType:Int = 1
     /// 一周的哪几天，只有当 remindFrequencyType == 2 时起作用
     var weekDays:[Int]?
     /// 鼓励语
     var encouragingSayings: String?
     /// 创建日期
     var createDate: Int?
     /// 已签到几天
     var signedDays:Int = 0
     */
       
    func createTable() -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS habit_training(id INTEGER PRIMARY KEY AUTOINCREMENT, habitId INT NOT NULL,alarms TEXT, remindFrequencyType INT NOT NULL,weekDays TEXT,encouragingSayings TEXT NOT NULL,createDate TEXT NOT NULL,signedDays INT NOT NULL);"
        
        self.dbQueue?.inDatabase { (db) -> Void in
            return db.executeStatements(sql)
        }
        
        return false
    }
    
    /// 新增
    /// - Parameter bean: bean
    /// - Parameter complete:complete
    func insert(bean: HHHabitTrainingResult,_ complete: (Bool) -> Void) -> Void {
        guard let habitId = bean.habitId else {
            complete(false)
            return
        }
        guard let remindFrequencyType = bean.remindFrequencyType else {
            complete(false)
            return
        }
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "INSERT INTO habit_training(habitId, alarms, remindFrequencyType, weekDays,encouragingSayings,createDate,signedDays) VALUES (?,?,?,?,?,?,?);"
                try db.executeUpdate(sql, values: [habitId,
                                                   bean.alarms ?? "",
                                                   remindFrequencyType,
                                                   bean.weekDays ?? "",
                                                   bean.encouragingSayings ?? "",
                                                   bean.createDate,
                                                   bean.signedDays])
                complete(true)
            } catch let error as NSError {
                print("insert error: \(error)")
                complete(false)
            }
        }
    }
    
    /// 删单条分类
    /// - Parameter id: id
    /// - Parameter complete: complete
    func delete(id: Int,_ complete: (Bool) -> Void) -> Void {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "delete from habit_training where id = ?"
                try db.executeUpdate(sql,values: [String(id)])
                complete(true)
            } catch let error as NSError {
                print("insert error: \(error)")
                complete(false)
            }
        }
    }
    
    /// 修改
    /// - Parameter bean: bean
    /// - Parameter complete:complete
    func update(bean: HHHabitTrainingResult,_ complete: (Bool) -> Void) -> Void{
        guard let id = bean.id else {
            complete(false)
            return
        }
        guard let habitId = bean.habitId else {
            complete(false)
            return
        }
        guard let remindFrequencyType = bean.remindFrequencyType else {
            complete(false)
            return
        }
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "UPDATE habit_training SET habitId = ?,alarms = ?,remindFrequencyType = ?,weekDays = ?,encouragingSayings = ?,createDate = ?,signedDays = ? where id = ?"
                try db.executeUpdate(sql,values:[habitId,
                                                    bean.alarms ?? "",
                                                    remindFrequencyType,
                                                    bean.weekDays ?? "",
                                                    bean.encouragingSayings ?? "",
                                                    bean.createDate,
                                                    bean.signedDays,
                                                    String(id)])
                complete(true)
            } catch let error as NSError {
                print("insert error: \(error)")
                complete(false)
            }
        }
    }
    
    /// 根据id查询
    /// - Parameter id: id
    /// - Parameter complete: complete
    func query(id: Int,_ complete: (HHHabitTrainingResult?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM habit_training where id = ?;"
                let result = try db.executeQuery(sql, values: [String(id)])
                 
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let habitId = result.int(forColumn: "habitId")
                    let alarms = result.string(forColumn: "alarms")
                    let remindFrequencyType = result.int(forColumn: "remindFrequencyType")
                    let weekDays = result.string(forColumn: "weekDays")
                    let encouragingSayings = result.string(forColumn: "encouragingSayings")
                    let createDate = result.string(forColumn: "createDate")
                    let signedDays = result.int(forColumn: "signedDays")
                    
                    let bean = HHHabitTrainingResult()
                    bean.id = Int(cid)
                    bean.habitId = Int(habitId)
                    bean.remindFrequencyType = Int(remindFrequencyType)
                    bean.alarms = alarms ?? ""
                    bean.weekDays = weekDays ?? ""
                    bean.encouragingSayings = encouragingSayings ?? ""
                    bean.createDate = createDate ?? ""
                    bean.signedDays = Int(signedDays)

                    print("id: \(cid), identifier: \(String(describing: encouragingSayings)), habitId: \(habitId)")
                    complete(bean)
                }
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    /// 查询所有
    /// - Parameter complete:complete
    func queryAll(_ complete: ([HHHabitTrainingResult]?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM habit_training;"
                let result = try db.executeQuery(sql, values: [3])

                var array = [HHHabitTrainingResult]()
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let habitId = result.int(forColumn: "habitId")
                    let alarms = result.string(forColumn: "alarms")
                    let remindFrequencyType = result.int(forColumn: "remindFrequencyType")
                    let weekDays = result.string(forColumn: "weekDays")
                    let encouragingSayings = result.string(forColumn: "encouragingSayings")
                    let createDate = result.string(forColumn: "createDate")
                    let signedDays = result.int(forColumn: "signedDays")
                    
                    let bean = HHHabitTrainingResult()
                    bean.id = Int(cid)
                    bean.habitId = Int(habitId)
                    bean.remindFrequencyType = Int(remindFrequencyType)
                    bean.alarms = alarms ?? ""
                    bean.weekDays = weekDays ?? ""
                    bean.encouragingSayings = encouragingSayings ?? ""
                    bean.createDate = createDate ?? ""
                    bean.signedDays = Int(signedDays)

                    print("id: \(cid), identifier: \(String(describing: encouragingSayings)), habitId: \(habitId)")
                     
                    array.append(bean)
                }
                complete(array)
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    // MARK: Transaction
    
}
