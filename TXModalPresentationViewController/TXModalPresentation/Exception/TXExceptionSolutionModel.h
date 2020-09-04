//
//  TXExceptionSolutionModel.h
//  QZX
//
//  Created by tianxi on 2020/9/3.
//  Copyright © 2020 Shanghai Tianxi Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 异常类型：出入金异常BALANCE，POSITION持仓异常
typedef NS_ENUM(NSInteger, TXExceptionType) {
    TXExceptionTypeBalance, // 出入金异常
    TXExceptionTypePosition,  // 持仓异常
};
/// 调整类型：资金调整BALANCE_TRANSFER，仓位调整POSITION_TRANSFER
typedef NS_ENUM(NSInteger, TXTransferType) {
    TXTransferTypeBalance, // 资金调整
    TXTransferTypePosition,  // 仓位调整
};
/// //出入金类型：WITHDRAW出金, DEPOSIT入金
typedef NS_ENUM(NSInteger, TXOperationType) {
    TXOperationTypeWithdraw, // 出金
    TXOperationTypeDeposit,  // 入金
};
 
@class TXExceptionModel,TXExceptionBodyModel,TXSolutionStepModel,TXSolutionStepBodyModel;
@interface TXExceptionSolutionModel : NSObject
/// 解决方案id
@property (nonatomic, copy) NSString *solutionId;
/// 交易账号
@property (nonatomic, copy) NSString *account;
/// 解决方案状态
@property (nonatomic, copy) NSString *solutionStatus;
@property (nonatomic, copy) NSArray <TXExceptionModel *>*exceptions;
@property (nonatomic, copy) NSArray <TXSolutionStepModel *>*solutionSteps;

/* convert property */
@property (nonatomic, copy) NSString *formatSolutionSteps;
@end

@interface TXExceptionModel : NSObject 
@property (nonatomic, copy) NSString *exceptionId;
/// 交易账号
@property (nonatomic, copy) NSString *account;
/// 时间
@property (nonatomic, copy) NSString *time;
/// 异常类型：出入金异常BALANCE，POSITION持仓异常
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) TXExceptionBodyModel *body;

/* convert property */
@property (nonatomic, assign) TXExceptionType formatType;
@property (nonatomic, copy) NSString *formatTime;
@property (nonatomic, copy) NSString *formatOperation;
@property (nonatomic, copy) NSString *formatDetail;
@end

@interface TXExceptionBodyModel : NSObject
@property (nonatomic, copy) NSString *exceptionId;
/// 出入金类型
@property (nonatomic, copy) NSString *operationType;
/// 发生金额
@property (nonatomic, copy) NSString *amount;
/// 交易所
@property (nonatomic, copy) NSString *exchangeId;
/// 合约代码
@property (nonatomic, copy) NSString *instrumentId;
/// 多空
@property (nonatomic, copy) NSString *direction;
/// 开平
@property (nonatomic, copy) NSString *offsetFlag;
/// 价格
@property (nonatomic, copy) NSString *price;
/// 手数
@property (nonatomic, copy) NSString *volume;
@property (nonatomic, copy) NSString *occurTime;

/* convert property */
@property (nonatomic, copy) NSString *formatOccurTime;
@property (nonatomic, copy) NSString *formatProductName;
@property (nonatomic, assign) TXOperationType formatOperationType;
@end

@interface TXSolutionStepModel : NSObject
@property (nonatomic, copy) NSString *solutionStepId;
@property (nonatomic, copy) NSString *assetUnitId;
@property (nonatomic, copy) NSString *assetUnitName;
/// 调整类型：资金调整BALANCE_TRANSFER，仓位调整POSITION_TRANSFER
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) TXSolutionStepBodyModel *body;

/* convert property */
@property (nonatomic, assign) TXTransferType formatType;
@end
 
@interface TXSolutionStepBodyModel : NSObject
@property (nonatomic, copy) NSString *assetUnitId;
@property (nonatomic, copy) NSString *assetUnitName;
@property (nonatomic, copy) NSString *amount;
/// 交易所
@property (nonatomic, copy) NSString *exchangeId;
/// 合约代码
@property (nonatomic, copy) NSString *instrumentId;
/// 多空
@property (nonatomic, copy) NSString *direction;
/// 开平
@property (nonatomic, copy) NSString *offsetFlag;
/// 价格
@property (nonatomic, copy) NSString *price;
/// 手数
@property (nonatomic, copy) NSString *volume;
@property (nonatomic, copy) NSString *occurTime;

/* convert property */
@property (nonatomic, copy) NSString *formatOccurTime;
@property (nonatomic, copy) NSString *formatProductName;
@end
NS_ASSUME_NONNULL_END
