//
//  PanGestureScrollView.h
//  zhefengle
//
//  Created by YMY on 15/11/23.
//  Copyright © 2015年 vanwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanGestureScrollView : UIScrollView<UIGestureRecognizerDelegate>

//在这个view上的滚动手势可以不被响应
@property(nonatomic, strong)UIView  *locationView;

@end
