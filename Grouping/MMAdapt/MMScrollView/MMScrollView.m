//
//  MMScrollView.m
//  CircleScrollView
//
//  Created by 橙子 on 15/8/20.
//  Copyright (c) 2015年 橙子. All rights reserved.
//

#import "MMScrollView.h"
#import "HWWeakTimer.h"
#import "UIImageView+WebCache.h"
#import "StyledPageControl.h"

@interface MMScrollView ()<UIScrollViewDelegate>
{
    NSInteger _trueTotalPageNumber;//真实的页数比总页数多两个.
    NSInteger _totalPageNumber;//数据源页数
    NSInteger _positionIndex;
}
@property (nonatomic,readonly) StyledPageControl    *pageControl;
@property (nonatomic, strong)  NSTimer          *timer;
@end

@implementation MMScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.pagingEnabled = true;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.showsVerticalScrollIndicator = false;
        _scrollView.scrollsToTop = NO;
        [self addSubview:_scrollView];
        
        _pageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-25, self.frame.size.width, 25)];
        _pageControl.diameter = 10;
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.userInteractionEnabled = NO;
        [_pageControl setCoreNormalColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
        [_pageControl setStrokeNormalColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
        [_pageControl setCoreSelectedColor:[UIColor whiteColor]];
        [_pageControl setStrokeSelectedColor:[UIColor whiteColor]];
        [_pageControl setPageControlStyle:PageControlStyleDefault];
        [self addSubview:_pageControl];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
            __weak typeof(self) weakSelf = self;
            _timer = [HWWeakTimer scheduledTimerWithTimeInterval:5 target:weakSelf selector:@selector(onTimer) userInfo:nil repeats:YES];
            [_timer setFireDate:[NSDate distantFuture]];
//        });
    }
    return self;
}


- (void)setImageURLArray:(NSArray *)imageURLArray
{
    _imageURLArray = nil;
    NSMutableArray *urlArray = [NSMutableArray arrayWithCapacity:imageURLArray.count];
    for (id url in imageURLArray) {
        if ([url isKindOfClass:[NSString class]]) {
            [urlArray addObject:[NSURL URLWithString:(NSString *)url]];
        } else if ([url isKindOfClass:[NSURL class]]) {
            [urlArray addObject: [(NSURL *)url copy]];
        }else {
            return;
        }
    }
    _imageURLArray = urlArray;
    _totalPageNumber = [imageURLArray count];
    _trueTotalPageNumber = [imageURLArray count]+2;
    
    if ([imageURLArray count] <= 1) {
        [_timer setFireDate:[NSDate distantFuture]];
        [_timer invalidate];
    }
    
    [self reloadScrollView];
}


- (void)reloadScrollView
{
    [self.timer setFireDate:[NSDate distantFuture]];
    if (self.scrollView) {
        NSInteger subViewCount = [[self.scrollView subviews] count];
        for (NSInteger i = 0; i < subViewCount; i++) {
            UIView *subView = [self.scrollView subviews][0];
            [subView removeFromSuperview];
        }
        _pageControl.numberOfPages = (int)_totalPageNumber;
        _pageControl.currentPage = 0;
        _positionIndex = 1;
        [self.scrollView setFrame:self.bounds];
        [self.pageControl setFrame:CGRectMake(0, self.frame.size.height-25, self.frame.size.width, 25)];
        [self.scrollView setContentSize:CGSizeMake(self.frame.size.width*_trueTotalPageNumber, self.frame.size.height)];
        if(_trueTotalPageNumber == 2){
            return;
        }
        UIImage *image = nil;
        if (_backImageType) {
            switch (_backImageType) {
                case ScrollViewBackImageTypeGoodsDetail:
                    image = [UIImage imageNamed:@"home_banner"];
                    break;
                    
                default:
                    break;
            }
        }
        for (NSInteger i = 0; i < _trueTotalPageNumber; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            NSInteger index = i;
            if (index == 0) {
                index = [self.imageURLArray count]-1;
            }else if (index == [self.imageURLArray count]+1){
                index = 0;
            }else{
                index--;
            }
            
            [imageView sd_setImageWithURL:self.imageURLArray[index] placeholderImage:image options:SDWebImageRetryFailed | SDWebImageRefreshCached];
            imageView.tag = index;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
            [imageView addGestureRecognizer:tap];
            [self.scrollView addSubview:imageView];
            [imageView setNeedsDisplay];
        }
        
        [_scrollView setContentOffset:CGPointMake(_positionIndex*_scrollView.frame.size.width, 0) animated:false];
        
        if (_totalPageNumber <= 1) {
            _pageControl.hidden = YES;
            [_timer setFireDate:[NSDate distantFuture]];
            _scrollView.scrollEnabled = NO;
        }else{
            _pageControl.hidden = NO;
            _scrollView.scrollEnabled = YES;
            [_timer setFireDate:[NSDate distantPast]];
            _positionIndex = -1;
        }
    }
}

- (void)onTimer
{
    if (_positionIndex == -1) {
        _positionIndex = 1;
        return;
    }
    if ([_imageURLArray count]<= 1) {
        return;
    }
    if (!_scrollView) {
        return;
    }
    _positionIndex ++;

    [_scrollView setContentOffset:CGPointMake(_positionIndex*self.frame.size.width, 0) animated:YES];
    _positionIndex = _positionIndex%_trueTotalPageNumber;
    if (_positionIndex == 0) {
        _positionIndex = _trueTotalPageNumber - 3;
        [_scrollView setContentOffset:CGPointMake((_positionIndex+1)*self.frame.size.width, 0)];
        _positionIndex = _trueTotalPageNumber - 3;
    }else if(_positionIndex == _trueTotalPageNumber-1){
        _positionIndex = 0;
        
        [_scrollView setContentOffset:CGPointMake((_positionIndex)*self.frame.size.width, 0)];
        _positionIndex = 1;
    }
    _pageControl.currentPage = (int)_positionIndex -1;
}

-(void)handleTap:(UITapGestureRecognizer*)gesture{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(scrollView:didClickedAtPage:)]){
        [self.delegate scrollView:self didClickedAtPage:gesture.view.tag];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_totalPageNumber==0 || _scrollView.contentOffset.x <= 0) {
        return;
    }
    
    CGFloat pageWidth = _scrollView.frame.size.width;
    NSInteger page = (_scrollView.contentOffset.x/pageWidth) + 0.5;
    if (page!=_positionIndex) {
        _positionIndex = page;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_positionIndex == 0) {
        _positionIndex = _trueTotalPageNumber - 3;
        [scrollView setContentOffset:CGPointMake((_positionIndex+1)*self.frame.size.width, 0)];
        _positionIndex = _trueTotalPageNumber - 3;
    }else if(_positionIndex == _trueTotalPageNumber-1){
        _positionIndex = 0;
        [scrollView setContentOffset:CGPointMake((_positionIndex+1)*self.frame.size.width, 0)];
        _positionIndex = 0;
    }else{
        _positionIndex = _positionIndex-1;
    }
    self.pageControl.currentPage = (int) _positionIndex;
}

- (void)setBackImageType:(ScrollViewBackImageType)backImageType{
    _backImageType = backImageType;
}

- (void)dealloc
{
    [_timer invalidate];
}

@end
