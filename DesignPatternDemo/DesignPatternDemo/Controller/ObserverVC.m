//
//  ObserverVC.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/3/31.
//  Copyright © 2020 hh. All rights reserved.
//

#import "ObserverVC.h"
#import "ConcreteObserver.h"
#import "ConcreteSubject.h"

@interface ObserverVC ()

@end

@implementation ObserverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //观察者
    ConcreteObserver *obs1 = [ConcreteObserver new];
    ConcreteObserver *obs2 = [ConcreteObserver new];
    ConcreteObserver *obs3 = [ConcreteObserver new];
    
    //被观察者
    ConcreteSubject *sub = [ConcreteSubject new];
    //添加观察者
    [sub addObserver:obs1];
    [sub addObserver:obs2];
    [sub addObserver:obs3];
    
//    [sub removeAllObservers];
    
    //做某事通知所有观察者
    [sub doSomething];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
