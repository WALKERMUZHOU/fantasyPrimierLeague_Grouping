//
//  UIImageView+DashLine.m
//  Grouping
//
//  Created by 朱成龙 on 2018/10/12.
//  Copyright © 2018 zmm. All rights reserved.
//

#import "UIImageView+DashLine.h"

@implementation UIImageView (DashLine)

//画一条虚线
- (UIImageView *)getDashLineImageBounds:(CGRect)bounds fromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor hightedLineLength:(CGFloat)hightedLineLength normalLineLength:(CGFloat)normalLineLength lineWidth:(CGFloat)lintWidth{
    UIImageView *dashLine = [[UIImageView alloc]initWithFrame:bounds];
    UIGraphicsBeginImageContext(dashLine.frame.size);
    [dashLine.image drawInRect:dashLine.bounds];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGFloat lengths[] = {hightedLineLength,normalLineLength};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, lineColor.CGColor);
    CGContextSetLineDash(line, 0, lengths, lintWidth);  //画虚线
    CGContextMoveToPoint(line, startPoint.x, startPoint.y);    //开始画线
    CGContextAddLineToPoint(line, endPoint.x,endPoint.y);
    CGContextStrokePath(line);
    dashLine.image = UIGraphicsGetImageFromCurrentImageContext();
    return dashLine;
}

@end
