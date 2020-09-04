//
//  TXExceptionSolutionModel.m
//  QZX
//
//  Created by tianxi on 2020/9/3.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import "TXExceptionSolutionModel.h"
#import "NSDate+TXAdd.h"
#import "TXInstListManager.h"
#import "TXMarketItemModel.h"

@implementation TXExceptionSolutionModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"exceptions" : [TXExceptionModel class],
             @"solutionSteps" : [TXSolutionStepModel class]
    };
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < self.solutionSteps.count; i++) {
        TXSolutionStepModel *solutionStep = self.solutionSteps[i];
        NSString *item;
        if (solutionStep.formatType == TXTransferTypeBalance) {// 出入金类型异常
            if (i == self.solutionSteps.count - 1) {
                item = [NSString stringWithFormat:@"【%@】：%@",solutionStep.assetUnitName,solutionStep.body.amount];
            } else {
                item = [NSString stringWithFormat:@"【%@】：%@\n",solutionStep.assetUnitName,solutionStep.body.amount];
            }
        } else {// 调整类型异常
            TXSolutionStepBodyModel *body = solutionStep.body;
            //开平仓类型：OPEN开仓,CLOSE平仓
            if (body.offsetFlag != nil && [body.offsetFlag isEqualToString:@"OPEN"]) { //OPEN开仓
                if (body.description != nil && [body.description isEqualToString:@"LONG"]) { //多
                    if (i == self.solutionSteps.count - 1) {
                        item = [NSString stringWithFormat:@"【%@】：%@、买开",solutionStep.assetUnitName,solutionStep.body.formatProductName];
                    } else {
                        item = [NSString stringWithFormat:@"【%@】：%@、买开\n",solutionStep.assetUnitName,solutionStep.body.formatProductName];
                    }
                } else { // 空
                    if (i == self.solutionSteps.count - 1) {
                        item = [NSString stringWithFormat:@"【%@】：%@、卖开",solutionStep.assetUnitName,solutionStep.body.formatProductName];
                    } else {
                        item = [NSString stringWithFormat:@"【%@】：%@、卖开\n",solutionStep.assetUnitName,solutionStep.body.formatProductName];
                    }
                }
            } else { //CLOSE平仓
                if (body.description != nil && [body.description isEqualToString:@"LONG"]) { //多
                    if (i == self.solutionSteps.count - 1) {
                        item = [NSString stringWithFormat:@"【%@】：%@、买平",solutionStep.assetUnitName,solutionStep.body.formatProductName];
                    } else {
                        item = [NSString stringWithFormat:@"【%@】：%@、买平\n",solutionStep.assetUnitName,solutionStep.body.formatProductName];
                    }
                } else { // 空
                    if (i == self.solutionSteps.count - 1) {
                        item = [NSString stringWithFormat:@"【%@】：%@、卖平",solutionStep.assetUnitName,solutionStep.body.formatProductName];
                    } else {
                        item = [NSString stringWithFormat:@"【%@】：%@、卖平\n",solutionStep.assetUnitName,solutionStep.body.formatProductName];
                    }
                }
            }
        }
        [string appendString:item];
    }
    _formatSolutionSteps = [string copy];
    return YES;
}
@end
 
@implementation TXExceptionModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
        @"exceptionId": @"id"
    };
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic { 
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.time doubleValue] / 1000];
    _formatTime = [date stringWithFormat:@"yyyy-MM-dd HH:mm"];
    
    if (self.type && [self.type isEqualToString:@"BALANCE"]) {
        _formatType = TXExceptionTypeBalance;
    } else if (self.type && [self.type isEqualToString:@"POSITION"]) {
        _formatType = TXExceptionTypePosition;
    }
    
    if (_formatType == TXExceptionTypeBalance) {
        _formatDetail = _body.amount;
        if (_body.formatOperationType == TXOperationTypeWithdraw) {
            _formatOperation = @"出金";
        } else if (_body.formatOperationType == TXOperationTypeDeposit) {
            _formatOperation = @"入金";
        }
    } else if (_formatType == TXExceptionTypePosition) {
        _formatDetail = [NSString stringWithFormat:@"%@ %@手",_body.formatProductName,_body.volume];
        //开平仓类型：OPEN开仓,CLOSE平仓
        if (_body.offsetFlag && [_body.offsetFlag isEqualToString:@"OPEN"]) {
            _formatOperation = @"开仓";
        } else if (_body.offsetFlag && [_body.offsetFlag isEqualToString:@"CLOSE"]) {
            _formatOperation = @"平仓";
        } else {
            _formatOperation = @"平仓";
        }
    }
     
    return YES;
}
@end
 
@implementation TXExceptionBodyModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
        @"exceptionId": @"id"
    };
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.occurTime doubleValue] / 1000];
    _formatOccurTime = [date stringWithFormat:@"yyyy-MM-dd HH:mm"];
     
    if (self.operationType && [self.operationType isEqualToString:@"WITHDRAW"]) {
        _formatOperationType = TXOperationTypeWithdraw;
    } else if (self.operationType && [self.operationType isEqualToString:@"DEPOSIT"]) {
        _formatOperationType = TXOperationTypeDeposit;
    }
    
    TXMarketItemModel *marketItemModel = [[TXInstListManager defaultManager] queryInstInfoByInstCode:self.instrumentId];
    if (marketItemModel) {
        _formatProductName = marketItemModel.ProductName;
    }
    
    return YES;
}
@end

@implementation TXSolutionStepModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
        @"solutionStepId": @"id"
    };
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (self.type && [self.type isEqualToString:@"BALANCE_TRANSFER"]) {
        _formatType = TXTransferTypeBalance;
    } else if (self.type && [self.type isEqualToString:@"POSITION_TRANSFER"]) {
        _formatType = TXTransferTypePosition;
    }
    return YES;
}
@end

@implementation TXSolutionStepBodyModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.occurTime doubleValue] / 1000];
    _formatOccurTime = [date stringWithFormat:@"yyyy-MM-dd HH:mm"];
    
    TXMarketItemModel *marketItemModel = [[TXInstListManager defaultManager] queryInstInfoByInstCode:self.instrumentId];
    if (marketItemModel) {
        _formatProductName = marketItemModel.ProductName;
    }
    
    return YES;
}
@end
 
