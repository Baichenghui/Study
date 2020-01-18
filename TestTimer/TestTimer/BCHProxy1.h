//
//  BCHProxy1.h
//  TestTimer
//
//  Created by 白成慧&瑞瑞 on 2019/3/15.
//  Copyright © 2019 白成慧. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//效率高，专门用来做消息转发;自己没有，直接消息转发，避免了去父类搜索消息的步骤
@interface BCHProxy1 : NSProxy
+(instancetype)proxyWithTarget:(id)target;
@property (nonatomic, weak) id target ;
@end

NS_ASSUME_NONNULL_END
