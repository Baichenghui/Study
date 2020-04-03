//
//  Header.h
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

@protocol IMediaProtocol <NSObject>

@property (nonatomic,copy) NSString *mediaId;
@property (nonatomic,copy) NSString *mediaUrl;
@property (nonatomic,copy) NSString *mediaName;

@end
