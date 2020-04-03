//
//  GameRole.m
//  DesignPatternDemo
//
//  Created by tianxi on 2020/4/3.
//  Copyright © 2020 hh. All rights reserved.
//

#import "GameRole.h"

@implementation GameRole

- (GameMemeno *)saveState {
    GameMemeno *memeno = [GameMemeno new];
    memeno.value = self.value;
    return memeno;
}

- (void)recovery:(GameMemeno *)memeno {
    self.value = memeno.value;
}

@end
