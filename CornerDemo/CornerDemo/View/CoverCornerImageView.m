//
//  CornerImageView.m
//  CornerDemo
//
//  Created by tianxi on 2019/12/11.
//  Copyright © 2019 hh. All rights reserved.
//

#import "CoverCornerImageView.h"

@implementation CoverCornerImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) { 
        UIImageView *_cornerCoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_cornerCoverImage setImage:[UIImage imageNamed:@"cornerAllCover"]];
        [self addSubview:_cornerCoverImage];
    }
    return self;
}

@end
