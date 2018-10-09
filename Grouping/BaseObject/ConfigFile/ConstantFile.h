//
//  ConstantFile.h
//  Grouping
//
//  Created by 朱成龙 on 2018/10/9.
//  Copyright © 2018 zmm. All rights reserved.
//

#ifndef ConstantFile_h
#define ConstantFile_h

/*----------------------屏幕高/宽-----------------------*/
#define kScreenHeight    [[UIScreen mainScreen]bounds].size.height
#define kScreenWidth     [[UIScreen mainScreen]bounds].size.width
#define iPhoneX          (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kNavigationBarHeight (kStatusBarHeight + 44.f)
#define KScreenHeightBar (kScreenHeight - kNavigationBarHeight)

/*----------------------控件高-----------------------*/
#define kTabBarHeight (iPhoneX ? 83.f : 49.f)

#define kBtnNormalHeight            35
#define kToolBarHeight              (iPhoneX ? 83.f : 49.f)
#define kToolBarContentHeight       49.f

#endif /* ConstantFile_h */
