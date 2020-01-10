//
//  HHStockScrollView.m
//  HHStockDemo
//
//  Created by tianxi on 2020/1/10.
//  Copyright © 2020 hh. All rights reserved.
//

#import "HHStockScrollView.h"
#import "UIColor+HHStock.h"
#import "HHStockVariable.h"
#import <Masonry/Masonry.h>

@implementation HHStockScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _contentView;
}

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.equalTo(@(contentSize.width));
        make.height.equalTo(self);
    }];
}


@end
