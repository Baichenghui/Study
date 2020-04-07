//
//  IRoughHouseProtocol.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/7.
//  Copyright © 2020 hh. All rights reserved.
//

//刚买的房子：毛坯房
//假设拥有的功能：
//毛坯房：只能交易,没装修没法居住
//简装房：可用居住，但是可能没有装电视，洗衣机，wifi
//精装修：想干啥都行
@protocol IHouseProtocol <NSObject>

/// 功能
- (void)showFuntion;

@end
