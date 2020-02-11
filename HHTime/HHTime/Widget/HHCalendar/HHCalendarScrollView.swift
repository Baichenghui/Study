//
//  HHCalendarScrollView.swift
//  HHTime
//
//  Created by 白成慧&瑞瑞 on 2019/11/30.
//  Copyright © 2019 hh. All rights reserved.
//

import UIKit

class HHCalendarScrollView: UIScrollView {

    lazy var collectionViewL: UICollectionView = {
        let frame = CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        let collectionView = UICollectionView.init(frame: frame, collectionViewLayout: self.collectFlowLayout)
        collectionView.register(HHCalendarCell.self, forCellWithReuseIdentifier: HHCalendarCell.HHCalendarCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    lazy var collectionViewC: UICollectionView = {
        let frame = CGRect.init(x: self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        let collectionView = UICollectionView.init(frame: frame, collectionViewLayout: self.collectFlowLayout)
        collectionView.register(HHCalendarCell.self, forCellWithReuseIdentifier: HHCalendarCell.HHCalendarCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    lazy var collectionViewR: UICollectionView = {
        let frame = CGRect.init(x: 2 * self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        let collectionView = UICollectionView.init(frame: frame, collectionViewLayout: self.collectFlowLayout)
        collectionView.register(HHCalendarCell.self, forCellWithReuseIdentifier: HHCalendarCell.HHCalendarCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    lazy var collectFlowLayout: UICollectionViewFlowLayout = {
        let collectFlowLayout = UICollectionViewFlowLayout.init()
        collectFlowLayout.itemSize = CGSize.init(width: self.bounds.size.width / 7.0, height: self.bounds.size.height / 6.0)
        collectFlowLayout.minimumLineSpacing = 0.0;
        collectFlowLayout.minimumInteritemSpacing = 0.0;
        collectFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        return collectFlowLayout
    }()
    
    var currentDate:Date?
    
    /// ScopeMonth : true:6 rows    false:1 rows
    var isScopeMonth:Bool = true
    
    var monthArray:[Dictionary<String, Any>] = [Dictionary<String, Any>]()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        currentDate = Date.init()
        
        HHCalendarLoader.loadAdjacentMonthCalendar(currentDate!) { (success, datas) in
            self.monthArray.append(contentsOf: datas)
            
            self.reloadAllDatas()
        }
 
        initSubViews()
        initLayoutSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews() {
        self.backgroundColor = UIColor.white
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.bounces = false
        self.delegate = self
        self.scrollsToTop = false
        self.contentSize = CGSize.init(width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        self.contentOffset = CGPoint.init(x: self.bounds.size.width, y: 0)
         
        self.addSubview(self.collectionViewL)
        self.addSubview(self.collectionViewC)
        self.addSubview(self.collectionViewR)
    }
    
    func initLayoutSubViews() {
        
    }

    func reloadAllDatas() {
        self.collectionViewL.reloadData()
        self.collectionViewC.reloadData()
        self.collectionViewR.reloadData()
    }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource

extension HHCalendarScrollView: UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HHCalendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: HHCalendarCell.HHCalendarCellID, for: indexPath) as! HHCalendarCell 
        if (collectionView == self.collectionViewL) {
            self.layoutCollections(cell, indexPath, 0)
        }
        else if (collectionView == self.collectionViewC) {
            self.layoutCollections(cell, indexPath, 1)
        }
        else if (collectionView == self.collectionViewR) {
            self.layoutCollections(cell, indexPath, 2)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let date = self.currentDate else { return  }
        
        if (scrollView.contentOffset.x < self.bounds.size.width) { // 向右滑动
            self.currentDate = HHDateUtil.previousMonthDate(date)
            HHCalendarLoader.loadAdjacentMonthCalendar(currentDate!) { (success, datas) in
                self.monthArray.removeAll()
                self.monthArray.append(contentsOf: datas)
                
                self.setScrollViewContentOffset()
                self.reloadAllDatas()
            } 
        }
        else if (scrollView.contentOffset.x > self.bounds.size.width) { // 向左滑动
            self.currentDate = HHDateUtil.nextMonthDate(date)
            HHCalendarLoader.loadAdjacentMonthCalendar(currentDate!) { (success, datas) in
                self.monthArray.removeAll()
                self.monthArray.append(contentsOf: datas)
                
                self.setScrollViewContentOffset()
                self.reloadAllDatas()
            }
        }
        else {
            setScrollViewContentOffset()
        }
    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.x == self.bounds.size.width
//            && scrollView.contentOffset.y == 0.00 && self.isScopeMonth {
//            setScrollViewContentOffset()
//        }
//    }

    fileprivate func layoutCollections(_ cell: HHCalendarCell,_ indexPath: IndexPath,_ dataIndex: Int) {
        if self.monthArray.count <= dataIndex  {
            return
        }
        
        let monthDictionary: Dictionary<String, Any> = self.monthArray[dataIndex]
        let dayDictionary:Dictionary<String,Any> = (monthDictionary["monthData"] as! [[String:Any]])[indexPath.row]
        cell.configDictionary(dayDictionary)
    }
    
    fileprivate func setScrollViewContentOffset() {
        let offsetY:CGFloat = 0
//        if self.isScopeMonth {
//            // 假如当前选中了31日，左滑或右滑 那个月没有31日，则需要选中那个月的最后一天
//           self.currentDateNumber = self.currentDateNumber > self.currentMonthDate.totalDaysInMonth ? self.currentMonthDate.totalDaysInMonth : self.currentDateNumber;
//
//           let index = [self.currentMonthDate firstWeekDayInMonth]+self.currentDateNumber;
//           let rows = index%7 == 0 ? index/7-1 : index/7;
//           offsetY = rows*(self.frame.size.height/6);
//        }
        self.contentOffset = CGPoint.init(x: self.bounds.size.width, y: offsetY)
    }
}


