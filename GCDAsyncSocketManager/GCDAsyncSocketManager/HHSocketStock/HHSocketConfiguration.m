//
//  HHSocketConfiguration.m
//  GCDAsyncSocketManager
//
//  Created by tianxi on 2019/12/25.
//  Copyright © 2019 hh. All rights reserved.
//

#import "HHSocketConfiguration.h"
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation HHSocketConfiguration

+ (instancetype)defaultConfiguration {
    HHSocketConfiguration *config = [[HHSocketConfiguration alloc] init]; 
    
    config.host = kcDXDefaultSocketHost;
    config.port = kcDXDefaultSocketPort;
    config.heartBeatCommand = DXCommandPing;
    config.handLoginCommand = DXCommandLogin;
    config.handLoginParams = [self loginParams];
    config.timeOut = -1;
    config.channel = kcHHSocket_DefaultChannel;
    config.maxReConnectCount = kMaxReConnectCount;
    
    config.heartBeatInterval = kcHHSocket_HeartBeatInterval;
    config.reConnectInterval = kcHHSocket_ReconnectInterval;
    config.autoReconnect = YES;
#if DEBUG
    config.enableLog = YES;
#else
    config.enableLog = NO;
#endif
    
    return config;
}

+ (nonnull NSDictionary*)loginParams {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:@"1.0.0" forKey:@"clientversion"];
    [params setObject:@1 forKey:@"clienttype"];
    NSString* user = ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
    NSString* version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    BOOL bVisitor = YES;
    //TODO: user
//    if ([AccountService.instance.account isActive]) {
//        bVisitor = NO;
//        user = AccountService.instance.account.userID;
//    }
    
    [params setObject:user forKey:@"user"];
    [params setObject:@(bVisitor) forKey:@"visitor"];
    [params setObject:version forKey:@"clientversion"];
    NSString* sign = [self hmac:user withKey:kcSocketConnectKey];
    [params setObject:sign ?: @"" forKey:@"sign"];
    return [params copy];
}

+ (NSString *)hmac:(NSString *)data withKey:(NSString *)key{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString *hash = [HMAC base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return hash;
}


@end
