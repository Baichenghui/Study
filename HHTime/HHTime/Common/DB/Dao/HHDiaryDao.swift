//
//  HHDiaryDao.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/12.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
import FMDB

struct HHDiaryDao {
    
    private var dbQueue: FMDatabaseQueue?
    public init?(queue: FMDatabaseQueue?){
        self.dbQueue = queue
    }
    
    func createTable() -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS diary(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,content TEXT NOT NULL,date TEXT,color TEXT);"
        
        self.dbQueue?.inDatabase { (db) -> Void in
            return db.executeStatements(sql)
        }
        
        return false
    }
    
    /// 新增
    /// - Parameter bean: bean
    /// - Parameter complete:complete
    func insert(bean: HHDiaryResult,_ complete: (Bool) -> Void) -> Void {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "INSERT INTO diary(title, content, date, color) VALUES (?,?,?,?);"
                try db.executeUpdate(sql, values: [bean.title ?? "",bean.content ?? "",bean.date ?? "",bean.color ?? ""])
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
    func delete(id: Int,_ complete: (Bool) -> Void) -> Void {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "delete from diary where id = ?"
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
                let sql = "delete from diary"
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
    func update(bean: HHDiaryResult,_ complete: (Bool) -> Void) -> Void{
        guard let id = bean.id else {
            complete(false)
            return
        }
         
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                let sql = "UPDATE diary SET title = ?,content = ?,date = ?,color = ? where id = ?"
                try db.executeUpdate(sql,values: [bean.title ?? "",bean.content ?? "",bean.date ?? "",bean.color ?? "",String(id)])
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
    func query(id: Int,_ complete: (HHDiaryResult?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM diary where id = ?;"
                let result = try db.executeQuery(sql, values: [String(id)])
                 
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let title = result.string(forColumn: "title")
                    let content = result.string(forColumn: "content")
                    let date = result.string(forColumn: "date")
                    let color = result.string(forColumn: "color")
                    print("id: \(id), title: \(String(describing: title)), content: \(String(describing: content))")
                    complete(HHDiaryResult(Int(cid), title ?? "", content ?? "",date ?? "",color ?? ""))
                }
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
     
    /// 查询所有
    /// - Parameter complete:complete
    func queryAll(_ complete: ([HHDiaryResult]?) -> Void) {
        self.dbQueue?.inDatabase { (db) -> Void in
            do {
                // 查询sql语句
                let sql = "SELECT * FROM diary;"
                let result = try db.executeQuery(sql, values: [3])

                var array = [HHDiaryResult]()
                while result.next() {
                    // 通过字段名称获取字段值
                    let cid = result.int(forColumn: "id")
                    let title = result.string(forColumn: "title")
                    let content = result.string(forColumn: "content")
                    let date = result.string(forColumn: "date")
                    let color = result.string(forColumn: "color")
                    array.append(HHDiaryResult(Int(cid), title ?? "", content ?? "",date ?? "",color ?? ""))
                    
                    print("id: \(cid), title: \(String(describing: title)), content: \(String(describing: content))")
                }
                complete(array)
            } catch let error as NSError {
                print("error: \(error)")
                complete(nil)
            }
        }
    }
    
    // MARK: Transaction
    
    func insert(list:[HHDiaryResult]) -> Void {
        self.dbQueue?.inTransaction({ (db, rollback) in
            for bean in list {
                insert(bean: bean) { (success) in }
            }
        })
    }
    
    func update(list:[HHDiaryResult]) -> Void {
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
