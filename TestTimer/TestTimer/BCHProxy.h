//
//  BCHProxy.h
//  TestTimer
//
//  Created by 白成慧&瑞瑞 on 2019/3/15.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCHProxy : NSObject
+(instancetype)proxyWithTarget:(id)target;
@property (nonatomic, weak) id target ;
@end

NS_ASSUME_NONNULL_END
