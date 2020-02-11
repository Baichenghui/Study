//
//  HHDaysMatterRepository.swift
//  HHTime
//
//  Created by tianxi on 2019/12/4.
//  Copyright © 2019 hh. All rights reserved.
//

import Foundation
import FMDB

internal struct HHDaysMatterRepository {
    
    /// 新建倒数日，肯定是在已选择的分类基础上操作，所以insert时不存在使用 Transaction
    static func insert(_ daysMatter:HHDaysMatterBean) {
        // bean -> entity
        
        let daysMatterEntity = HHDaysMatterResult.init()
        daysMatterEntity.id = daysMatter.id;
        daysMatterEntity.categoryId = daysMatter.category?.id
        daysMatterEntity.name = daysMatter.name;
        daysMatterEntity.targetDate = daysMatter.targetDate;
        daysMatterEntity.endDate = daysMatter.endDate;
        daysMatterEntity.isTop = daysMatter.isTop;
        daysMatterEntity.isLunar = daysMatter.isLunar;
        daysMatterEntity.repeatType = daysMatter.repeatType;
        
        HHSQLiteManager.shared.getDaysMatterDao().insert(bean: daysMatterEntity) { (success) in
             
        }
    }
    
    // MARK: Transaction
    
//    /// 新建倒数日，肯定是在已选择的分类基础上操作，所以insert时不存在使用 Transaction
//    static func insert(_ daysMatter:HHDaysMatterBean) {
//        // bean -> entity
//
//        let daysMatterEntity = HHDaysMatterResult.init()
//        daysMatterEntity.id = daysMatter.id;
//        daysMatterEntity.categoryId = daysMatter.category?.id
//        daysMatterEntity.name = daysMatter.name;
//        daysMatterEntity.targetDate = daysMatter.targetDate;
//        daysMatterEntity.endDate = daysMatter.endDate;
//        daysMatterEntity.isTop = daysMatter.isTop;
//        daysMatterEntity.isLunar = daysMatter.isLunar;
//        daysMatterEntity.repeatType = daysMatter.repeatType;
//
//        let categoryEntity = HHCategoryResult.init()
//        categoryEntity.id = daysMatter.category?.id
//        categoryEntity.name = daysMatter.category?.name
//        categoryEntity.type = daysMatter.category?.type
//        categoryEntity.isDefault = daysMatter.category?.isDefault
//
//        HHSQLiteManager.shared.getDBQueue()?.inTransaction({ (db, rollback) in
//            var successAll = true
//            HHSQLiteManager.shared.getDaysMatterDao().insert(bean: daysMatterEntity) { (success) in
//                if !success {
//                    successAll = false
//                }
//            }
//            HHSQLiteManager.shared.getCategoryDao().insert(bean: categoryEntity) { (success) in
//                if !success {
//                    successAll = false
//                }
//            }
//
//            if !successAll {
//                db.rollback()
//            }
//        })
//    }
    
    static func query(_ id:Int,_ complete: (HHDaysMatterBean?) -> Void) {
        HHSQLiteManager.shared.getDBQueue()?.inTransaction({ (db, rollback) in
            HHSQLiteManager.shared.getDaysMatterDao().query(id: id) { (daysMatter) in
                guard let daysMatter = daysMatter,
                    let categoryId = daysMatter.categoryId else {
                    complete(nil)
                    return
                }
                let bean = HHDaysMatterBean.init()
                 
                bean.id = daysMatter.id;
                bean.name = daysMatter.name;
                bean.targetDate = daysMatter.targetDate;
                bean.endDate = daysMatter.endDate;
                bean.isTop = daysMatter.isTop;
                bean.isLunar = daysMatter.isLunar;
                bean.repeatType = daysMatter.repeatType;
                
                HHSQLiteManager.shared.getCategoryDao().query(id: categoryId) { (category) in
                    guard let category = category else {
                        complete(nil)
                        return
                    }
                    
                    let categoryBean = HHCategoryBean.init()
                    categoryBean.id = category.id
                    categoryBean.name = category.name
                    categoryBean.type = category.type
                    categoryBean.isDefault = category.isDefault
                    
                    bean.category = categoryBean
                    complete(bean)
                }
            }
        })
    }
}
