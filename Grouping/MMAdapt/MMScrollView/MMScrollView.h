
//
//  MMScrollView.h
//  CircleScrollView
//
//  Created by zmm on 15/8/20.
//  Copyright (c) 2015年 zmm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ScrollViewBackImageType){
    ScrollViewBackImageTypeGoodsDetail = 1,
};
@class MMScrollView;
@protocol MMScrollViewDelegate <NSObject>

-(void)scrollView:(MMScrollView *)scrollView didClickedAtPage:(NSInteger)pageIndex;

@end

@interface MMScrollView : UIView

@property (nonatomic, strong)UIScrollView   *scrollView;
@property (nonatomic, strong)NSArray        *imageURLArray;
@property (nonatomic, weak)id<MMScrollViewDelegate>delegate;
@property (nonatomic, assign) ScrollViewBackImageType   backImageType;


@end


