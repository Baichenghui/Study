//
//  HHDaysMatterTable.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/2.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
import FMDB


//类型（1、事项提醒；2、日历事件；3、笔记；）
public let kMemoTypeReminder = 1
public let kMemoTypeEvent = 2
public let kMemoTypeNote = 3

struct HHMemoDao {
    
    private var dbQueue: FMDatabaseQueue?
    public init?(queue: FMDatabaseQueue?){
        self.dbQueue = queue
    }
    
    func createTable() -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS memo(id INTEGER PRIMARY KEY AUTOINCREMENT, identifier TEXT,type INT NOT NULL);"
        
        self.dbQueue?.inDatabase { (db) -> Void in
            return db.executeStatements(sql)
        }
        
        return false
    }
    
    /// 新增
    /// - Parameter bean: bean
    /// - Parameter complete:complete
    func insert(bean: HHMemoResult,_ complete: (Bool) -> Void) -> Void {
        guard let identifier = bean.identifier else {
            complete(false)
            return
        }
        guard let type = bean.type else {
            complete(false)
            return
        }
        
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "INSERT INTO memo(identifier, type) VALUES (?,?);"
                try db.executeUpdate(sql, values: [identifier,type])
                complete(true)
            } catch let error as NSError {
                print("insert error: \(error)")
                complete(false)
            }
        }
    }
    
    /// 删单条
    /// - Parameter id: id
    /// - Parameter complete: complete
    func delete(identifier: String,_ complete: (Bool) -> Void) -> Void {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "delete from memo where identifier = ?"
                try db.executeUpdate(sql,values: [identifier])
                complete(true)
            } catch let error as NSError {
                print("insert error: \(error)")
                complete(false)
            }
        }
    }
    
    /// 删除所有行
    /// - Parameter complete:complete
    func deleteAll(_ complete: (Bool) -> Void) -> Void {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "delete from memo"
                try db.executeUpdate(sql,values: [])
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
    func update(bean: HHMemoResult,_ complete: (Bool) -> Void) -> Void{
        guard let id = bean.id else {
            complete(false)
            return
        }
        guard let identifier = bean.identifier else {
            complete(false)
            return
        }
        guard let type = bean.type else {
            complete(false)
            return
        }
         
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "UPDATE memo SET identifier = ?,type = ? where id = ?"
                try db.executeUpdate(sql,values: [identifier,type,String(id)])
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
    func query(id: Int,_ complete: (HHMemoResult?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM mome where id = ?;"
                let result = try db.executeQuery(sql, values: [String(id)])
                 
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let identifier = result.string(forColumn: "identifier")
                    let type = result.int(forColumn: "type")
                    print("id: \(id), identifier: \(String(describing: identifier)), type: \(type)")
                    complete(HHMemoResult(Int(cid), identifier ?? "", Int(type)))
                }
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    /// 根据identifier查询
    /// - Parameter identifier: identifier
    /// - Parameter complete: complete
    func query(identifier: String,_ complete: (HHMemoResult?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM mome where identifier = ?;"
                let result = try db.executeQuery(sql, values: [identifier])
                 
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let identifier = result.string(forColumn: "identifier")
                    let type = result.int(forColumn: "type")
                    print("id: \(cid), identifier: \(String(describing: identifier)), type: \(type)")
                    complete(HHMemoResult(Int(cid), identifier ?? "", Int(type)))
                }
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    /// 查询所有
    /// - Parameter complete:complete
    func queryAll(_ complete: ([HHMemoResult]?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM memo;"
                let result = try db.executeQuery(sql, values: [3])

                var array = [HHMemoResult]()
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let identifier = result.string(forColumn: "identifier")
                    let type = result.int(forColumn: "type")
                    array.append(HHMemoResult(Int(cid), identifier ?? "", Int(type)))
                    print("id: \(cid), identifier: \(String(describing: identifier)), type: \(type)")
                }
                complete(array)
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    // MARK: Transaction
    
    func insert(list:[HHMemoResult]) -> Void {
        self.dbQueue?.inTransaction({ (db, rollback) in
            for bean in list {
                insert(bean: bean) { (success) in }
            }
        })
    }
    
    func update(list:[HHMemoResult]) -> Void {
        self.dbQueue?.inTransaction({ (db, rollback) in
            for bean in list {
                update(bean: bean) { (success) in }
            }
        })
    }
     
    func delete(list:[String]) -> Void {
        self.dbQueue?.inTransaction({ (db, rollback) in
            for identifier in list {
                delete(identifier: identifier) { (success) in }
            }
        })
    }
}
