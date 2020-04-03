//
//  GameMemeno.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameMemeno : NSObject
//需要保存已经恢复的属性
@property (nonatomic,copy) NSString *value;
@end

NS_ASSUME_NONNULL_END
