//
//  AppDelegate.m
//  AlgorithmDemo
//
//  Created by 白成慧&瑞瑞 on 2020/1/7.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    RootViewController *rooViewController = [[RootViewController alloc] init];
    UINavigationController *navgationController = [[UINavigationController alloc]initWithRootViewController:rooViewController];
    self.window.rootViewController = navgationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

 

@end
