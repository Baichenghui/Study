//
//  HHCategoryDao.swift
//  HHTime
//
//  Created by tianxi on 2019/11/4.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
import FMDB

///// 分类表
////id
//let id_category = rowid
////名称
//let name_category = Expression<String>("categoryName")
////类型（1、倒数日；2、备忘录；3、爱好；4、...）
//let type_category = Expression<Int>("categoryType")
////创建时间
//let createTime_category = Expression<Int>("categoryCreateTime")
////修改时间
//let updateTime_category = Expression<Int>("categoryUpdateTime")
////默认数据(1, 0)
//let isDefault = Expression<Int>("isDefault")


//类型（1、倒数日；2、备忘录；3、爱好；4、...）
public let kCategoryTypeDaysMatter = 1
public let kCategoryTypeMemo = 2
public let kCategoryTypeHabitTraining = 3

class HHCategoryDao {
    
    private var dbQueue: FMDatabaseQueue?
    public init?(queue: FMDatabaseQueue?){
        self.dbQueue = queue
    }
      
    func createTable() -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS category(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,type INT NOT NULL,isDefault INT NOT NULL);"
        
        self.dbQueue?.inDatabase { (db) -> Void in
            return db.executeStatements(sql)
        }
        
        return false
    }
    
    /// 新增
    /// - Parameter bean: bean
    /// - Parameter complete:complete
    func insert(bean: HHCategoryResult,_ complete: (Bool) -> Void) -> Void {
        guard let name = bean.name else {
            complete(false)
            return
        }
        guard let type = bean.type else {
            complete(false)
            return
        }
        guard let isDefault = bean.isDefault else {
            complete(false)
            return
        }
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "INSERT INTO category(name, type, isDefault) VALUES (?,?,?);"
                try db.executeUpdate(sql, values: [name,type,isDefault])
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
                let sql = "delete from category where id = ?"
                try db.executeUpdate(sql,values: [String(id)])
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
                let sql = "delete from category"
                try db.executeUpdate(sql,values: [])
                complete(true)
            } catch let error as NSError {
                print("insert error: \(error)")
                complete(false)
            }
        }
    }
    
    /// 修改分类
    /// - Parameter bean: bean
    /// - Parameter complete:complete
    func update(bean: HHCategoryResult,_ complete: (Bool) -> Void) -> Void{
        guard let id = bean.id else {
            complete(false)
            return
        }
        guard let name = bean.name else {
            complete(false)
            return
        }
        guard let type = bean.type else {
            complete(false)
            return
        }
         
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "UPDATE category SET name = ?,type = ? where id = ?"
                try db.executeUpdate(sql,values: [name,type,String(id)])
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
    func query(id: Int,_ complete: (HHCategoryResult?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM category where id = ?;"
                let result = try db.executeQuery(sql, values: [String(id)])
                 
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let name = result.string(forColumn: "name")
                    let type = result.int(forColumn: "type")
                    let isDefault = result.int(forColumn: "isDefault")
                    print("id: \(id), name: \(String(describing: name)), type: \(type)")
                    complete(HHCategoryResult(Int(cid), name ?? "", Int(type),Int(isDefault)))
                }
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    /// 查询所有
    /// - Parameter complete:complete 
    func queryAll(_ complete: ([HHCategoryResult]?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM category;"
                let result = try db.executeQuery(sql, values: [3])

                var array = [HHCategoryResult]()
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let name = result.string(forColumn: "name")
                    let type = result.int(forColumn: "type")
                    let isDefault = result.int(forColumn: "isDefault")
                    array.append(HHCategoryResult(Int(cid), name ?? "", Int(type),Int(isDefault)))
                    print("id: \(cid), name: \(String(describing: name)), type: \(type)")
                }
                complete(array)
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    // MARK: Transaction
    
    func insert(list:[HHCategoryResult]) -> Void {
        self.dbQueue?.inTransaction({ (db, rollback) in
            for bean in list {
                insert(bean: bean) { (success) in }
            }
        })
    }
    
    func update(list:[HHCategoryResult]) -> Void {
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
