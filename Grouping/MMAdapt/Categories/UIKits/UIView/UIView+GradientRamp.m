//
//  UIView+GradientRamp.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/12.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "UIView+GradientRamp.h"

@implementation UIView (GradientRamp)
- (UIView *)addGradientRampToView:(UIView *)view fromColor:(UIColor *)fromColor ToColor:(UIColor *)toColor{
    [view.layer addSublayer:[[self class] setGradualChangingColor:view fromColor:fromColor toColor:toColor]];
    return view;
}

//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor{
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}

@end
