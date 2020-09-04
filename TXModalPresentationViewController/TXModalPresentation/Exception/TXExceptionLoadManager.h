//
//  TXExceptionLoadManager.h
//  QZX
//
//  Created by tianxi on 2020/9/3.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXNetworkingConfig.h"
#import "TXExceptionSolutionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TXExceptionLoadManager : NSObject
/// 我的异常通知列表
+ (void)mineExceptionsWithSuccess:(void (^)(TXExceptionSolutionModel *data))success
                          failure:(void (^)(NSError *error))failure;

/// 我的异常解决方案通知列表
+ (void)mineExceptionSolutionsWithSuccess:(void (^)(TXExceptionSolutionModel *data))success
                                  failure:(void (^)(NSError *error))failure;

/// 客户确认方案
+ (void)mineExceptionSolutionsPutWithSolutionId:(NSString *)solutionId;

/// 方案处理结果
+ (void)mineExceptionSolutionsGetWithSolutionId:(NSString *)solutionId
                                        success:(void (^)(TXExceptionSolutionModel *data))success
                                        failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
