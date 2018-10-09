//
//  MMFreshHeader.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "MMFreshHeader.h"

@interface MMFreshHeader(){
    __unsafe_unretained UIImageView *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@property (weak, nonatomic) UILabel *stateLabel;
@property (strong, nonatomic) NSMutableDictionary *stateTitles;

@end


@implementation MMFreshHeader

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel mj_label]];
        _stateLabel.font = [UIFont systemFontOfSize:12];
        _stateLabel.textColor = [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:1];
    }
    return _stateLabel;
}

- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (void)prepare{
    [super prepare];
    [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中" forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews{
    [super placeSubviews];
    
    CGFloat stateLabelH = self.mj_h * 0.5;
    self.stateLabel.mj_x = 0;
    self.stateLabel.mj_y = self.mj_h*0.5;
    self.stateLabel.mj_w = self.mj_w;
    self.stateLabel.mj_h = stateLabelH;
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        CGFloat stateWidth = self.stateLabel.mj_textWith;
        arrowCenterX -= stateWidth / 2 + 15;
    }
    CGFloat arrowCenterY = self.stateLabel.center.y;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    self.loadingView.center = arrowCenter;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    self.stateLabel.text = self.stateTitles[@(state)];
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
            }];
        } else {
            [self.loadingView stopAnimating];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.loadingView.alpha = 0.0;
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
    }
}
@end
