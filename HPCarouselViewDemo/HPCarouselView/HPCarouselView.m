//
//  HPCarouselView.m
//  HPCarouselViewDemo
//
//  Created by hp on 16/2/28.
//  Copyright © 2016年 hxp. All rights reserved.
//

#import "HPCarouselView.h"
#import "SDWebImage/UIButton+WebCache.h"

#define SELF_WIDTH (self.frame.size.width)
#define CAROUSEL_SCROLL_TIME 3  //轮播间隔时间

#define RGB_COLOR(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

@interface HPCarouselView ()
{
    NSInteger scrollItemCount;
    NSTimer   *scrollTimer;
}

@property (nonatomic, retain) UIScrollView  *carouselScrollView;
@property (nonatomic, retain) UIPageControl *carouselPageControl;

@end

@implementation HPCarouselView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addSubview:self.carouselScrollView];
        [self addSubview:self.carouselPageControl];
        [self resetScrollTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray
{
    self = [self initWithFrame:frame];
    if (self) {
        [self hp_loadImageWithArray:imageArray];
    }
    return self;
}

-(void)hp_loadImageWithArray:(NSArray *)imageArray
{
    NSMutableArray *scrollImageArray = [[NSMutableArray alloc] init];
    
    if ([imageArray count] > 1) {
        [scrollImageArray addObject:[imageArray lastObject]];
        [scrollImageArray addObjectsFromArray:imageArray];
        [scrollImageArray addObject:[imageArray firstObject]];
    }
    else if([imageArray count] == 1)
    {
        [scrollImageArray addObjectsFromArray:imageArray];
    }
    
    scrollItemCount = [scrollImageArray count];
    
    _carouselScrollView.contentSize = CGSizeMake(self.frame.size.width * scrollItemCount, _carouselScrollView.frame.size.height);
    
    for (UIView *view in [_carouselScrollView subviews]) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < scrollItemCount; i ++) {
        
        UIButton *headButton  = [[UIButton alloc] initWithFrame:CGRectMake(_carouselScrollView.frame.size.width * i, 0.0f, _carouselScrollView.frame.size.width, _carouselScrollView.frame.size.height)];
        headButton.backgroundColor = RGB_COLOR(240, 240, 240);
        if ([scrollImageArray[i] isKindOfClass:[UIImage class]]) {
            [headButton setImage:scrollImageArray[i] forState:UIControlStateNormal];
        }
        else if ([scrollImageArray[i] isKindOfClass:[NSString class]] )
        {
            [headButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[scrollImageArray objectAtIndex:i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] forState:UIControlStateNormal];
        }
        [headButton setAdjustsImageWhenHighlighted:NO];
        [headButton addTarget:self action:@selector(carouselItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_carouselScrollView addSubview:headButton];
    }
    
    if (scrollItemCount > 1) {
        //当只有1张图片的时候，就不用设置偏移
        [_carouselScrollView setContentOffset:CGPointMake(_carouselScrollView.frame.size.width, 0) animated:NO];
    }
    
    _carouselPageControl.numberOfPages = [imageArray count];
    
}

-(void)resetScrollTimer
{
    if (scrollTimer && [scrollTimer isValid]) {
        [scrollTimer invalidate], scrollTimer = nil;
    }
    
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:CAROUSEL_SCROLL_TIME target:self selector:@selector(scrollCarouselView) userInfo:nil repeats:YES];
}

-(void)scrollCarouselView
{
    if (scrollItemCount <= 1) {
        return;
    }
    
    NSInteger currentPage = _carouselPageControl.currentPage;
    [_carouselScrollView setContentOffset:CGPointMake((currentPage + 2) * _carouselScrollView.frame.size.width, 0.0f) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    
    if (scrollItemCount < 3) {
        return;
    }
    
    if (sender.contentOffset.x <= 0) {
        [sender setContentOffset:CGPointMake( _carouselScrollView.contentSize.width - (_carouselScrollView.frame.size.width * 2), 0.0f) animated:NO];
        return;
    }
    
    if (sender.contentOffset.x >= _carouselScrollView.contentSize.width - _carouselScrollView.frame.size.width) {
        [sender setContentOffset:CGPointMake( _carouselScrollView.frame.size.width, 0.0f) animated:NO];
        return;
    }

    _carouselPageControl.currentPage = floor(((sender.contentOffset.x - sender.frame.size.width) - SELF_WIDTH/2) / SELF_WIDTH) + 1;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollTimer && [scrollTimer isValid]) {
        [scrollTimer invalidate], scrollTimer = nil;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self resetScrollTimer];
}

-(void)carouselItemClicked:(UIButton *)sender
{
    [self.delegate hp_carouselItemClicked:sender];
}

#pragma mark - setter and getter
-(UIScrollView *)carouselScrollView
{
    if (!_carouselScrollView) {
        self.carouselScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _carouselScrollView.backgroundColor = RGB_COLOR(240, 240, 240);
        _carouselScrollView.pagingEnabled = YES;
        _carouselScrollView.showsHorizontalScrollIndicator = NO;
        _carouselScrollView.showsVerticalScrollIndicator = NO;
        _carouselScrollView.scrollsToTop = NO;
        _carouselScrollView.delegate = self;
    }
    
    return _carouselScrollView;
}

-(UIPageControl *)carouselPageControl
{
    if (!_carouselPageControl) {
        self.carouselPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_carouselScrollView.frame.size.width/2 - 60.0f/2, self.frame.size.height - 20.0f, 60.0f, 10.0f)];
        _carouselPageControl.currentPage = 0;
    }
    
    return _carouselPageControl;
}

@end
