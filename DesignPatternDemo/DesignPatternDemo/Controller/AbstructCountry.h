//
//  AbstructCountry.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstructUnitedNations.h"

NS_ASSUME_NONNULL_BEGIN

@interface AbstructCountry : NSObject
-(instancetype)initWithMeditor:(AbstructUnitedNations *) meditor;
@property (nonatomic,strong) AbstructUnitedNations *meditor;
@end

NS_ASSUME_NONNULL_END
