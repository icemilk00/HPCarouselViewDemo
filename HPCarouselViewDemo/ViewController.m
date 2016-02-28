//
//  ViewController.m
//  HPCarouselViewDemo
//
//  Created by hp on 16/2/28.
//  Copyright © 2016年 hxp. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, strong) HPCarouselView *carouselView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.carouselView];
}

#pragma mark - setter and getter
-(HPCarouselView *)carouselView
{
    if (!_carouselView) {
        //数组中也可以传图片的地址，NSString* 类型
        NSArray *imageArray = @[[UIImage imageNamed:@"11.jpg"],[UIImage imageNamed:@"22.jpg"],[UIImage imageNamed:@"33.jpg"],[UIImage imageNamed:@"44.jpg"],[UIImage imageNamed:@"55.jpg"]];
        self.carouselView = [[HPCarouselView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.view.frame.size.width, 200.0f) ImageArray:imageArray];
    }
    
    return _carouselView;
}

-(void)hp_carouselItemClicked:(UIButton *)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
