//
//  HHHabitTypeDao.swift
//  HHTime
//
//  Created by tianxi on 2019/12/2.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
import FMDB

struct HHHabitDao {
    
    private var dbQueue: FMDatabaseQueue?
    public init?(queue: FMDatabaseQueue?){
        self.dbQueue = queue
    }
        
    /*
     var id: Int 
     /// 1：生活，2：工作，3：学习，4：其他，5：自定义
     var type: Int = 1
     var title: String = ""
     var icon: String = ""
     var bgColor: String = ""
     */
    func createTable() -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS habit(id INTEGER PRIMARY KEY AUTOINCREMENT, type INT NOT NULL,title TEXT NOT NULL,icon TEXT NOT NULL,bgColor TEXT NOT NULL);"
        
        self.dbQueue?.inDatabase { (db) -> Void in
            return db.executeStatements(sql)
        }
        
        return false
    }
    
    /// 新增
    /// - Parameter bean: bean
    /// - Parameter complete:complete
    func insert(bean: HHHabitResult,_ complete: (Bool) -> Void) -> Void {
        guard let type = bean.type else {
            complete(false)
            return
        }
        guard let title = bean.title else {
            complete(false)
            return
        }
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "INSERT INTO habit(type, title, icon, bgColor) VALUES (?,?,?,?);"
                try db.executeUpdate(sql, values: [type,title,bean.icon ?? "",bean.bgColor ?? ""])
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
                let sql = "delete from habit where id = ?"
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
    func update(bean: HHHabitResult,_ complete: (Bool) -> Void) -> Void{
        guard let id = bean.id else {
            complete(false)
            return
        }
        guard let type = bean.type else {
            complete(false)
            return
        }
        guard let title = bean.title else {
            complete(false)
            return
        }
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "UPDATE habit SET type = ?,title = ?,icon = ?,bgColor = ? where id = ?"
                try db.executeUpdate(sql,values: [type,title,bean.icon ?? "",bean.bgColor ?? "",String(id)])
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
    func query(id: Int,_ complete: (HHHabitResult?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM habit where id = ?;"
                let result = try db.executeQuery(sql, values: [String(id)])
                 
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let type = result.int(forColumn: "type")
                    let title = result.string(forColumn: "title")
                    let icon = result.string(forColumn: "icon")
                    let bgColor = result.string(forColumn: "bgColor")
                    
                    let bean = HHHabitResult()
                    bean.id = Int(cid)
                    bean.type = Int(type)
                    bean.title = title ?? ""
                    bean.icon = icon ?? ""
                    bean.bgColor = bgColor ?? ""
                    
                    print("id: \(id), identifier: \(String(describing: title)), type: \(type)")
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
    func queryAll(_ complete: ([HHHabitResult]?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM habit;"
                let result = try db.executeQuery(sql, values: [3])

                var array = [HHHabitResult]()
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let type = result.int(forColumn: "type")
                    let title = result.string(forColumn: "title")
                    let icon = result.string(forColumn: "icon")
                    let bgColor = result.string(forColumn: "bgColor")
                    
                    let bean = HHHabitResult()
                    bean.id = Int(cid)
                    bean.type = Int(type)
                    bean.title = title ?? ""
                    bean.icon = icon ?? ""
                    bean.bgColor = bgColor ?? ""
                    
                    array.append(bean)
                    print("id: \(cid), identifier: \(String(describing: title)), type: \(type)")
                }
                complete(array)
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    func getLastInsertRowid(_ complete: (Int) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT last_insert_rowid() FROM habit;"
                let result = try db.executeQuery(sql, values: [3])
                
                var lastId = -1
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let type = result.int(forColumn: "type")
                    let title = result.string(forColumn: "title")
                    let icon = result.string(forColumn: "icon")
                    let bgColor = result.string(forColumn: "bgColor")
                    
                    let bean = HHHabitResult()
                    bean.id = Int(cid)
                    bean.type = Int(type)
                    bean.title = title ?? ""
                    bean.icon = icon ?? ""
                    bean.bgColor = bgColor ?? ""
                      
                    lastId = Int(cid)
                } 
                
                lastId = Int(db.lastInsertRowId)
                
                complete(lastId)
            } catch let error as NSError {
                print("error: \(error)")
                complete(-1)
            }
        }
    }
}
