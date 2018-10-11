//
//  MMJumpTool.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/11.
//  Copyright © 2018 zmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MMJumpTool : NSObject

+ (void)pushViewController:(UIViewController *)viewController;

+ (void)pushViewController:(UIViewController *)viewController animate:(BOOL)animated;

+ (void)presentViewController:(UIViewController *)viewController animate:(BOOL)animated;

+ (void)popToRootViewController;

+ (void)popToCurrentRootViewController;


@end

NS_ASSUME_NONNULL_END
