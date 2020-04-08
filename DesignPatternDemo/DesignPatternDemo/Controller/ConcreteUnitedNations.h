//
//  ConcreteUnitedNations.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AbstructUnitedNations.h"
#import "USA.h"
#import "Irag.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConcreteUnitedNations : AbstructUnitedNations
@property (nonatomic,strong)USA *c1;
@property (nonatomic,strong)Irag *c2;
@end

NS_ASSUME_NONNULL_END
