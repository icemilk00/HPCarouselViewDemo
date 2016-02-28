//
//  HPCarouselView.h
//  HPCarouselViewDemo
//
//  Created by hp on 16/2/28.
//  Copyright © 2016年 hxp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HPCarouselViewDelegate <NSObject>

-(void)hp_carouselItemClicked:(UIButton *)sender;

@end

@interface HPCarouselView : UIView <UIScrollViewDelegate>


@property (nonatomic, assign) id <HPCarouselViewDelegate> delegate;

/*
 *  imageArray 里的元素可以是 UIImage * 类型,也可以是图片的地址 NSString * 类型。
 *  可以两种类型混传
 */

- (id)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray;
- (void)hp_loadImageWithArray:(NSArray *)imageArray;

@end
