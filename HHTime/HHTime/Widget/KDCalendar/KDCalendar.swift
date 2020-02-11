//
//  KDCalendar.swift
//  KeepDiary
//
//  Created by 白成慧&瑞瑞 on 2018/5/5.
//  Copyright © 2018年 白成慧. All rights reserved.
//

import UIKit

protocol KDCalendarDelegate : class {
    func calendar(_ calendar: KDCalendar, contentHeight height: CGFloat)
    func calendar(_ calendar: KDCalendar, didDate date: Date)
}

class KDCalendar: UIView {
    static let KDCalendarDateCellID = "KDCalendarDateCell"
    
    public weak var delegate : KDCalendarDelegate?
    
    private var itemHeight: CGFloat = 0
    private var style: KDCalendarAppearStyle
    private var currentSelectCell: KDCalendarDateCell?
    
    private var monthDateArray = [Dictionary<String, Any>]()
    private var monthData = Dictionary<String, Any>()
    private var firstDay: Int = 0
    private var currentMonth: Int = 1
    
    lazy var contentView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: self.contentView.bounds, collectionViewLayout: self.collectFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    lazy var collectFlowLayout: UICollectionViewFlowLayout = {
        let collectFlowLayout = UICollectionViewFlowLayout.init()
        collectFlowLayout.minimumLineSpacing = 0.0;
        collectFlowLayout.minimumInteritemSpacing = 0.0;
        collectFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        return collectFlowLayout
    }()
    
    lazy var headerView: KDCalendarHeaderView = {
        let headerView = KDCalendarHeaderView.init(style: self.style, frame: CGRect.init())
        headerView.backgroundColor = UIColor(colorString: "f7f7f7")
        return headerView
    }()
    
    // MARK: - Life Cycle and Initialized
    
    init(style: KDCalendarAppearStyle, frame: CGRect) {
        self.style = style
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    func setupUI() {
        self.addSubview(self.headerView)
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.collectionView)
        self.collectionView.register(KDCalendarDateCell.self, forCellWithReuseIdentifier: KDCalendar.KDCalendarDateCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.bounds.size.width;
        self.headerView.frame = CGRect.init(x: 0, y: 0, width: width, height: (self.style.headerViewHeihgt!));
        layoutCollectionView()
    }
    
    func layoutCollectionView() {
        
        let itemWidth = Int(self.bounds.size.width) / (self.style.weekDateDays.count);
        var itemHeight = itemWidth;
        if((self.style.isNeedCustomHeihgt)! && (self.style.itemHeight)! > 0.0) {
            itemHeight = Int((self.style.itemHeight)!)
        }
        self.itemHeight = CGFloat(itemHeight);
        
        self.collectFlowLayout.itemSize = CGSize.init(width: CGFloat(itemWidth), height: CGFloat(itemHeight))
        
        //collectinView高度
        let collectionViewHeight = self.itemHeight * 6;
        
        self.collectionView.frame = CGRect.init(x: 0, y: 0, width: Int(self.bounds.size.width), height: Int(collectionViewHeight));
        
        self.contentView.frame = CGRect.init(x: 0, y: self.headerView.frame.maxY, width: self.bounds.size.width, height: CGFloat(Int(collectionViewHeight)))
        self.collectionView.collectionViewLayout = self.collectFlowLayout
        
        delegate?.calendar(self, contentHeight: self.style.headerViewHeihgt! + collectionViewHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    //MARK: - Public
    
    //MARK: - Private
    
    //MARK: - Setter And Getter
     
    public func setMonthData(monthData: Dictionary<String, Any>) {
        self.monthData = monthData
        self.monthDateArray = monthData["monthData"] as! [Dictionary<String, Any>]
        
//        self.currentMonth = monthData["currentMonth"] as! Int
        self.firstDay = monthData["firstDay"] as! Int
        
//        self.headerView.setDate(date:"\(self.currentMonth) 月")
        
        self.collectionView.reloadData()
    }
}


//MARK: - Delegate

extension KDCalendar: UICollectionViewDelegate,UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.monthDateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dictionary: Dictionary<String, Any> = self.monthDateArray[indexPath.row]
        
        let cell: KDCalendarDateCell = collectionView.dequeueReusableCell(withReuseIdentifier: KDCalendar.KDCalendarDateCellID, for: indexPath) as! KDCalendarDateCell
        cell.contentView.backgroundColor = UIColor.white
        
        if let month = dictionary["month"] {
            cell.setDateDictionary(dictionary: dictionary,isCurrentMonth: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dictionary: Dictionary<String, Any> = self.monthDateArray[indexPath.row]
        
        if let day = dictionary["day"],
            let month = dictionary["month"],
            let year = dictionary["year"]
        {
//            if currentMonth == (month as! Int) {
//                let dateString = String(format: "%d-", (year as! Int)) + String(format: "%.2d-", (month as! Int)) + String(format: "%.2d", (day as! Int))
////                print(dateString)
//
//                delegate?.calendar(self, didDate: stringConvertDate(string: dateString, dateFormat: "yyyy-MM-dd"))
//            } else {
//                print("...")
//            }
        }
    }
}


