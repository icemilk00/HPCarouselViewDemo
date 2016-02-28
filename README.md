# CalendarDemo

一个轻量的轮播组件,作为轮子我就放到这里，大概效果可以看下面这张图： 

<!-- ![show image](https://github.com/icemilk00/CalendarDemo/blob/master/show_image.gif) -->

用法简介
===

1.初始化
---
	self.carouselView = [[HPCarouselView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.view.frame.size.width, 200.0f) ImageArray:imageArray];
    _carouselView.delegate = self;
    [self.view addSubview:self.carouselView];

参数imageArray可以放 UIImage * 类型,也可以是图片的地址 NSString * 类型。也可以两种类型混传。

2.完成delegate里方法 
---
代理里主要是点击轮播item时的响应事件
	
	-(void)hp_carouselItemClicked:(UIButton *)sender; 

3.重新load轮播组件的图片时
---
请调用：
	
	- (void)hp_loadImageWithArray:(NSArray *)imageArray;


PS:我这里的参数imageArray元素都是图片或图片地址。根据实际情况你们有可能传数据model之类的，请自行修改源码里的代码。

文件介绍
===

HPCarouselView  		轮播组件本体  
SDWebImage				用于加载网络图片，如果你们自己的项目里有这个，就不加这个也可以。


CalendarViewController	//控制器，换成你自己的 

感谢
===
[思路来源这个博客](http://blog.csdn.net/jasonblog/article/details/21977481)
一部分代码也是看完后直接拿过来的，我把一部分逻辑直接封装到组件里了，他的又有一个类专门控制逻辑。

