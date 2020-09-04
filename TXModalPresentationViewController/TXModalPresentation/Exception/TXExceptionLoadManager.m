//
//  TXExceptionLoadManager.m
//  QZX
//
//  Created by tianxi on 2020/9/3.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXExceptionLoadManager.h"
 
@implementation TXExceptionLoadManager

/// 我的异常通知列表
+ (void)mineExceptionsWithSuccess:(void (^)(TXExceptionSolutionModel *data))success
                          failure:(void (^)(NSError *error))failure {
    [TXHttpShared GET:@"http://qa-sl-qzx-gw.xgt588.com/api/mine/exceptions" parameters:nil success:^(id  _Nullable responseObject) {
        TXExceptionSolutionModel *model = [TXExceptionSolutionModel yy_modelWithJSON:responseObject];
        if (success) {
            success(model);
        }
    } failure:^(NSError * _Nonnull error) {
         if (failure) {
             failure(error);
         }
    }];
}

/// 我的异常解决方案通知列表
+ (void)mineExceptionSolutionsWithSuccess:(void (^)(TXExceptionSolutionModel *data))success
                                  failure:(void (^)(NSError *error))failure {
    [TXHttpShared GET:@"http://qa-sl-qzx-gw.xgt588.com/api/mine/exception-solutions" parameters:nil success:^(id  _Nullable responseObject) {
        TXExceptionSolutionModel *model = [TXExceptionSolutionModel yy_modelWithJSON:responseObject];
        if (success) {
            success(model);
        }
    } failure:^(NSError * _Nonnull error) {
         if (failure) {
             failure(error);
         }
    }];
}

/// 客户确认方案
+ (void)mineExceptionSolutionsPutWithSolutionId:(NSString *)solutionId {
    [TXHttpShared PUT:[NSString stringWithFormat:@"http://qa-sl-qzx-gw.xgt588.com/api/mine/exception-solutions/%@",solutionId] parameters:nil success:^(id  _Nullable responseObject) {
         
    } failure:^(NSError * _Nonnull error) {
          
    }];
}

/// 方案处理结果
+ (void)mineExceptionSolutionsGetWithSolutionId:(NSString *)solutionId
                                     success:(void (^)(TXExceptionSolutionModel *data))success
                                     failure:(void (^)(NSError *error))failure {
    [TXHttpShared GET:[NSString stringWithFormat:@"http://qa-sl-qzx-gw.xgt588.com/api/mine/exception-solutions/%@",solutionId] parameters:nil success:^(id  _Nullable responseObject) {
        TXExceptionSolutionModel *model = [TXExceptionSolutionModel yy_modelWithJSON:responseObject];
        if (success) {
            success(model);
        }
    } failure:^(NSError * _Nonnull error) {
         if (failure) {
             failure(error);
         }
    }];
}


@end
