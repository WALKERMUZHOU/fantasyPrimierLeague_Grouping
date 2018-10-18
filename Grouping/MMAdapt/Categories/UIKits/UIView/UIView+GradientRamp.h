//
//  UIView+GradientRamp.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/12.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GradientRamp)

- (UIView *)addGradientRampToView:(UIView *)view fromColor:(UIColor *)fromColor ToColor:(UIColor *)toColor;

@end

NS_ASSUME_NONNULL_END
