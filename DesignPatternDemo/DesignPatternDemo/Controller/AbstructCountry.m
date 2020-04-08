//
//  AbstructCountry.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AbstructCountry.h"

@implementation AbstructCountry

-(instancetype)initWithMeditor:(AbstructUnitedNations *) meditor {
    if (self = [super init]) {
        self.meditor = meditor;
    }
    return self;
}

@end
