//
//  MMRefreshFooter.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMRefreshFooter.h"

@interface MMRefreshFooter ()

@property (nonatomic, strong) UIView    *nomoreDataView;

@end

@implementation MMRefreshFooter

- (void)prepare{
    [super prepare];
    
}

- (void)placeSubviews{
    [super placeSubviews];
    if (self.state == MJRefreshStateNoMoreData) {
        self.stateLabel.text = @"";
        if (!self.nomoreDataView) {
            self.nomoreDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
            self.nomoreDataView.backgroundColor = [UIColor clearColor];
            [self addSubview:self.nomoreDataView];
            self.nomoreDataView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            
            UILabel *label = [[UILabel alloc]initWithFrame:self.nomoreDataView.bounds];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"别拉了,到底了";
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:1];
            [self.nomoreDataView addSubview:label];
            if (self.normoreDataStr) {
                label.text = self.normoreDataStr;
            }
            
            UIView *leftLine = [[UIView alloc]init];
            leftLine.frame = CGRectMake(12, self.nomoreDataView.center.y -0.5, self.nomoreDataView.frame.size.width/2 - 12 - 50, 0.5);
            leftLine.backgroundColor = [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:1];
            [self.nomoreDataView addSubview:leftLine];
            
            UIView *rightLine = [[UIView alloc]init];
            rightLine.frame = CGRectMake(self.nomoreDataView.frame.size.width/2 - 50, self.nomoreDataView.center.y - 0.5, self.nomoreDataView.frame.size.width/2 - 12 - 50, 0.5);
            rightLine.backgroundColor = [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:1];
            [self.nomoreDataView addSubview:rightLine];
            
        }
    }else{
        if (self.nomoreDataView) {
            [self.nomoreDataView removeFromSuperview];
            self.nomoreDataView = nil;
        }
    }
}

@end
