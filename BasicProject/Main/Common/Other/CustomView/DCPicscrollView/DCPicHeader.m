//
//  DCPicHeader.m
//   
//
//  Created by 宋亚清 on 16/3/18.
//  Copyright © 2016年  . All rights reserved.
//

#import "DCPicHeader.h"
@implementation DCPicHeader
-(void)addDLScrollWithUrlArray:(NSArray *)UrlStringArray  bgview:(UIView *)bgview frame:(CGRect)picFrame
{ 
//    NSMutableArray *imageA = [[NSMutableArray alloc]initWithCapacity:0];
//    NSMutableArray *titleA = [[NSMutableArray alloc]initWithCapacity:0];
//    NSMutableArray *detailA = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *imageUrls = [[NSMutableArray alloc]initWithCapacity:0];
//    for (BannerModel  *model in UrlStringArray ) {
//        NSString *url = [NSString stringWithFormat:@"%@/uploads/%@",newServiceHead,model.imgurl];
//        [imageUrls addObjectCheck:url];
//        NSLog(@"BannerModel 地址 %@",url);
//    }
    
//    for (NSString  *url in UrlStringArray ) {
//        [imageA addObjectCheck:url];
//    }
    //显示顺序和数组顺序一致
    //设置图片url数组,和滚动视图位置  原来高240  CGRectMake(0, -20,SCREEN_WIDTH,PX(400))
    _picView = [DCPicScrollView picScrollViewWithFrame:picFrame WithImageUrls:imageUrls];
    _picView.backgroundColor = [UIColor greenColor];
    //显示顺序和数组顺序一致
    //设置标题显示文本数组
    _picView.style = PageControlAtCenter;
//    _picView.titleData = titleA;
//    _picView.detailData = detailA;
//    _picView.modelData = UrlStringArray;
    //占位图片,你可以在下载图片失败处修改占位图片
//    _picView.PageControl.indicatorMargin = PX(20);
//    _picView.PageControl.indicatorDiameter = PX(26);
    _picView.placeImage = [UIImage imageNamed:DEFAULT_PLACE_BANNER];
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    _picView.contentMode = UIViewContentModeScaleAspectFill;
    
    //default is 2.0f,如果小于0.5不自动播放
    _picView.AutoScrollDelay = imageUrls.count > 1 ? 2.5f : 0;
    //    picView.textColor = [UIColor redColor];
    
    [bgview addSubview:_picView];
    
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
//    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
//        NSLog(@"%@",error);
//    }];
    
}

-(void)addDLScrolWithUrlArray:(NSArray *)UrlArray  view:(UIView *)bgview{
    NSMutableArray *imageUrls = [[NSMutableArray alloc]initWithCapacity:0];
//    for (BannerModel  *model in UrlArray ) {
//        NSString *url = [NSString stringWithFormat:@"%@/uploads/%@",newServiceHead,model.imgurl];
//        [imageUrls addObjectCheck:url];
//    }
    
    //显示顺序和数组顺序一致
    //设置图片url数组,和滚动视图位置  原来高240
    _picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,PX(250)) WithImageUrls:imageUrls];
    //显示顺序和数组顺序一致
    _picView.style = PageControlAtCenter;
    //占位图片,你可以在下载图片失败处修改占位图片
    _picView.placeImage = [UIImage imageNamed:@""];
    //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
    _picView.contentMode = UIViewContentModeScaleAspectFill;
    //default is 2.0f,如果小于0.5不自动播放
    _picView.AutoScrollDelay = 3.f;
    [bgview addSubview:_picView];
    
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
    //    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
    //        NSLog(@"%@",error);
    //    }];
}

@end
