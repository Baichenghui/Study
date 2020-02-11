//
//  HHDaysMatterTable.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/2.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
import FMDB

///// 倒数日表
////id
//let id_daysMatter = rowid
////事件名称
//let name_daysMatter = Expression<String>("nameDaysMatter")
////目标日期
//let targetDate_daysMatter = Expression<String>("targetDateDaysMatter")
////结束 日期
//let endDate_daysMatter = Expression<String>("endDateDaysMatter")
////分类 id
//let categoryId_daysMatter = Expression<Int>("categoryIdDaysMatter")
////是否置顶
//let isTop_daysMatter = Expression<Int>("isTopDaysMatter")
////是否是农历
//let isLunar_daysMatter = Expression<Int>("isLunarDaysMatter")
////重复类型（0、不重复；1、周重复；2、月重复；3、年重复；4、天重复）
//let repeatType_daysMatter = Expression<Int>("repeatTypeDaysMatter")

class HHDaysMatterDao {
    private var dbQueue: FMDatabaseQueue?
    public init?(queue: FMDatabaseQueue?){
        self.dbQueue = queue
    }
      
    func createTable() -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS daysMatter(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,targetDate INT NOT NULL,endDate INT NOT NULL,categoryId INT NOT NULL,isTop INT NOT NULL,isLunar INT NOT NULL,repeatType INT NOT NULL);"
        
        self.dbQueue?.inDatabase { (db) -> Void in
            return db.executeStatements(sql)
        }
        
        return false
    }
    
    /// 增加
    /// - Parameter bean: bean
    /// - Parameter complete:complete
    func insert(bean:HHDaysMatterResult,_ complete: (Bool) -> Void) -> Void {
        guard let name = bean.name else {
            complete(false)
            return
        }
        guard let targetDate = bean.targetDate else {
            complete(false)
            return
        }
        guard let isTop = bean.isTop else {
            complete(false)
            return
        }
        guard let categoryId = bean.categoryId else {
            complete(false)
            return
        }
        guard let endDate = bean.endDate else {
            complete(false)
            return
        }
        guard let isLunar = bean.isLunar else {
            complete(false)
            return
        }
        guard let repeatType = bean.repeatType else {
            complete(false)
            return
        }
        
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "INSERT INTO daysMatter(name, targetDate, endDate, categoryId, isTop, isLunar, repeatType) VALUES (?,?,?,?,?,?,?);"
                try db.executeUpdate(sql, values: [name,targetDate,endDate,categoryId,isTop,isLunar,repeatType])
                complete(true)
            } catch let error as NSError {
                print("insert error: \(error)")
                complete(false)
            }
        }
    }
     
    /// 删单条分类
    /// - Parameter id: id
    /// - Parameter complete:complete
    func delete(id: Int,_ complete: (Bool) -> Void) -> Void {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "delete from daysMatter where id = ?"
                try db.executeUpdate(sql,values: [String(id)])
                complete(true)
            } catch let error as NSError {
                print("insert error: \(error)")
                complete(false)
            }
        }
    }
     
    /// 修改分类
    /// - Parameters:
    ///   - id: id
    ///   - bean: bean
    ///   - complete:complete
    func update(bean: HHDaysMatterResult,_ complete: (Bool) -> Void) -> Void {
        guard let id = bean.id else {
            complete(false)
            return
        }
        guard let name = bean.name else {
            complete(false)
            return
        }
        guard let targetDate = bean.targetDate else {
            complete(false)
            return
        }
        guard let isTop = bean.isTop else {
            complete(false)
            return
        }
        guard let categoryId = bean.categoryId else {
            complete(false)
            return
        }
        guard let endDate = bean.endDate else {
            complete(false)
            return
        }
        guard let isLunar = bean.isLunar else {
            complete(false)
            return
        }
        guard let repeatType = bean.repeatType else {
            complete(false)
            return
        }
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "UPDATE daysMatter SET name = ?,targetDate = ?,endDate = ?,categoryId = ?,isTop = ?,isLunar = ?,repeatType = ? where id = ?"
                try db.executeUpdate(sql,values: [name, targetDate, endDate, categoryId, isTop, isLunar, repeatType,String(id)])
                complete(true)
            } catch let error as NSError {
                print("insert error: \(error)")
                complete(false)
            }
        }
         
    }
    
    /// 根据id查询
    /// - Parameter id: id
    /// - Parameter complete:complete
    func query(id: Int,_ complete: (HHDaysMatterResult?) -> Void) -> Void {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM daysMatter where id = ?;"
                let result = try db.executeQuery(sql, values: [String(id)])

                while result.next() {
                    // 通过字段名称获取字段值
                    let id = result.int(forColumn: "id")
                    let name = result.string(forColumn: "name")
                    let targetDate = result.int(forColumn: "targetDate")
                    let endDate = result.int(forColumn: "endDate")
                    let categoryId = result.int(forColumn: "categoryId")
                    let isTop = result.int(forColumn: "isTop")
                    let isLunar = result.int(forColumn: "isLunar")
                    let repeatType = result.int(forColumn: "repeatType")
                    print("id: \(id), name: \(String(describing: name)), repeatType: \(repeatType)")
                    complete(HHDaysMatterResult(Int(id), name ?? "", Int(targetDate), Int(endDate), Int(categoryId), Int(isTop), Int(isLunar), Int(repeatType)))
                }
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    /// 查询所有
    /// - Parameter complete:complete
    func queryAll(_ complete: ([HHDaysMatterResult]?) -> Void) -> Void {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM daysMatter;"
                let result = try db.executeQuery(sql, values: [3])

                var array = [HHDaysMatterResult]()
                while result.next() {
                    // 通过字段名称获取字段值
                    let id = result.int(forColumn: "id")
                    let name = result.string(forColumn: "name")
                    let targetDate = result.int(forColumn: "targetDate")
                    let endDate = result.int(forColumn: "endDate")
                    let categoryId = result.int(forColumn: "categoryId")
                    let isTop = result.int(forColumn: "isTop")
                    let isLunar = result.int(forColumn: "isLunar")
                    let repeatType = result.int(forColumn: "repeatType")
                    array.append(HHDaysMatterResult(Int(id), name ?? "", Int(targetDate), Int(endDate), Int(categoryId), Int(isTop), Int(isLunar), Int(repeatType)))
                    
                    print("id: \(id), name: \(String(describing: name)), repeatType: \(repeatType)")
                }
                complete(array)
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    // MARK: Transaction
      
    func insert(list:[HHDaysMatterResult]) -> Void {
        self.dbQueue?.inTransaction({ (db, rollback) in
            for bean in list {
                insert(bean: bean) { (success) in }
            }
        })
    }
    
    func update(list:[HHDaysMatterResult]) -> Void {
        self.dbQueue?.inTransaction({ (db, rollback) in
            for bean in list {
                update(bean: bean) { (success) in }
            }
        })
    }
     
    func delete(list:[Int]) -> Void {
        self.dbQueue?.inTransaction({ (db, rollback) in
            for id in list {
                delete(id: id) { (success) in }
            }
        })
    }
}
