//
//  AppDelegate.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *rooViewController = [[ViewController alloc] init];
    UINavigationController *navgationController = [[UINavigationController alloc]initWithRootViewController:rooViewController];
    self.window.rootViewController = navgationController;
    [self.window makeKeyAndVisible];
     
    return YES;
}
 

@end
