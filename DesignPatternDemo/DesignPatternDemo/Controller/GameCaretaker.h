//
//  GameCaretaker.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameMemeno.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameCaretaker : NSObject

//编辑器撤销功能，五子棋的悔棋功能等等都可以运用，这时需要用一个数组来保存
//@property (nonatomic,strong)NSMutableArray<GameMemeno *> *mememoList;

//只有上一次状态恢复，用一个备忘录就行
@property (nonatomic,strong)GameMemeno *memeno;

@end

NS_ASSUME_NONNULL_END
