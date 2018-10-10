//
//  PanGestureScrollView.m
//  zhefengle
//
//  Created by YMY on 15/11/23.
//  Copyright © 2015年 vanwell. All rights reserved.
//

#import "PanGestureScrollView.h"

@interface PanGestureScrollView()

@end

@implementation PanGestureScrollView


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
    if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [gestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *_scrollView = (UIScrollView *)gestureRecognizer.view;
        UIPanGestureRecognizer *fullScreenPanGesture = (UIPanGestureRecognizer *)otherGestureRecognizer;
        CGPoint fullScreenPanGesturePoint = [fullScreenPanGesture translationInView:otherGestureRecognizer.view];
        if (fullScreenPanGesturePoint.x > 0&&_scrollView.contentOffset.x <= 0) {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (_locationView) {
        CGPoint p = [gestureRecognizer locationInView:_locationView];
        if (p.y < _locationView.frame.size.height) {
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

@end
