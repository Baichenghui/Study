//
//  AbstructUnitedNations.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/8.
//  Copyright © 2020 hh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AbstructCountry;

NS_ASSUME_NONNULL_BEGIN

@interface AbstructUnitedNations : NSObject

- (void)declare:(NSString *)msg country:(AbstructCountry *)country;
@end

NS_ASSUME_NONNULL_END
