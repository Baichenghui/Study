//
//  HHDataBaseManager.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/2.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
import FMDB

class HHSQLiteManager: NSObject {
    /// 单例
    internal static let shared = HHSQLiteManager.init()
    
    /// 阻止其他对象使用这个类的默认的'()'初始化方法
    private override init() {
        super.init()
        
        initDB()
        
        createTable()
        
        buildDefaultCategory()
    }

    /// dbQueue
    private var dbQueue: FMDatabaseQueue?
    
    /// 分类
    private var categoryDao: HHCategoryDao?
    /// 倒数日
    private var daysMatterDao: HHDaysMatterDao?
    /// 习惯养成
    private var habitTrainingDao: HHHabitTrainingDao?
    /// 习惯
    private var habitDao: HHHabitDao?
    /// 备忘录
    private var memoDao: HHMemoDao?
    
    private var diaryDao: HHDiaryDao?
    
    func getDBQueue() -> FMDatabaseQueue? {
        return dbQueue
    }
        
    func getDaysMatterDao() -> HHDaysMatterDao {
        if daysMatterDao == nil {
            daysMatterDao = HHDaysMatterDao.init(queue: dbQueue)
        }
        return daysMatterDao!
    }
    
    func getHabitDao() -> HHHabitDao {
        if habitDao == nil {
            habitDao = HHHabitDao.init(queue: dbQueue)
        }
        return habitDao!
    }
    
    func getHabitTrainingDao() -> HHHabitTrainingDao {
        if habitTrainingDao == nil {
            habitTrainingDao = HHHabitTrainingDao.init(queue: dbQueue)
        }
        return habitTrainingDao!
    }
    
    func getMemoDao() -> HHMemoDao {
        if memoDao == nil {
            memoDao = HHMemoDao.init(queue: dbQueue)
        }
        return memoDao!
    }
    
    func getDiaryDao() -> HHDiaryDao {
        if diaryDao == nil {
            diaryDao = HHDiaryDao.init(queue: dbQueue)
        }
        return diaryDao!
    }
     
    func getCategoryDao() -> HHCategoryDao {
        if categoryDao == nil {
            categoryDao = HHCategoryDao.init(queue: dbQueue)
        }
        return categoryDao!
    }
    
    /// 创建数据库
    private func initDB(){
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = documentPath.appending("/hhTime.db")
        print("path: \(path)")

        // 创建FMDatabaseQueue对象会自动打开数据库,如果数据库不存在会创建数据库
        // 后续的所有数据库操作都是通过dbQueue来调用
        dbQueue = FMDatabaseQueue(path: path)
    }
    
    private func createTable() -> Void {
        let _ = getDaysMatterDao().createTable()
        let _ = getCategoryDao().createTable()
        let _ = getMemoDao().createTable()
        let _ = getDiaryDao().createTable()
    }
    
    private func buildDefaultCategory() -> Void {
        let hasSetCategoryDefaultDB = HHUserDefaultUtil.get(key: HHUserDefaultUtil.kInitCategoryDBKey)
        if !(hasSetCategoryDefaultDB != nil) {
            getCategoryDao().insert(bean: HHCategoryResult.init(1,"生活", kCategoryTypeDaysMatter, 1)) { (success) in}
            getCategoryDao().insert(bean: HHCategoryResult.init(2,"工作", kCategoryTypeDaysMatter, 1)) { (success) in}
            getCategoryDao().insert(bean: HHCategoryResult.init(3,"纪念日", kCategoryTypeDaysMatter, 1)) { (success) in}
            
            HHUserDefaultUtil.set(key: HHUserDefaultUtil.kInitCategoryDBKey,value: true)
        }
    }
    
    //MARK: - Transaction DaysMatter
    
}
