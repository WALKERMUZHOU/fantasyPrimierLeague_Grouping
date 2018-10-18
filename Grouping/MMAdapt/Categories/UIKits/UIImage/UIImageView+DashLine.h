//
//  UIImageView+DashLine.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/12.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (DashLine)

/**
 *  画一条虚线.
 *
 *  @param bounds               虚线的bounds
 *  @param startPoint           虚线开始画得点
 *  @param endPoint             虚线结束的点
 *  @param lineColor            虚线高亮部分显示的颜色
 *  @param hightedLineLength    虚线高亮部分的长度
 *  @param normalLineLength     虚线普通部分的长度
 *  @param lintWidth            虚线的宽度
 *
 *  @return return value description
 */
- (UIImageView *)getDashLineImageBounds:(CGRect)bounds fromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor hightedLineLength:(CGFloat)hightedLineLength normalLineLength:(CGFloat)normalLineLength lineWidth:(CGFloat)lintWidth;

@end

NS_ASSUME_NONNULL_END
