//
//  DCPicScrollView.m
//  DCPicScrollView
//
//  Created by dengchen on 15/12/4.
//  Copyright © 2015年 name. All rights reserved.
//

#define myWidth self.frame.size.width
#define myHeight self.frame.size.height
#define pageSize (myHeight * 0.2 > 25 ? 25 : myHeight * 0.2)

#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "MyPageControl.h"
@interface DCPicScrollView () <UIScrollViewDelegate>

@property (nonatomic,copy) NSArray *imageData;

@end

@implementation DCPicScrollView{
    
    __weak  UIImageView *_leftImageView,*_centerImageView,*_rightImageView;
    
    __weak  UILabel *_leftLabel,*_centerLabel,*_rightLabel;
    __weak  UILabel *_leftDetail,*_centerDetail,*_rightDetail;
    
    __weak  UIScrollView *_scrollView;
    
    __weak  MyPageControl *_PageControl;
    
    UIView *_centerPlay;
    NSTimer *_timer;
    
    NSInteger _currentIndex;
    
    NSInteger _MaxImageCount;
    
    BOOL _isNetwork;
    
    BOOL _hasTitle;
}


- (void)setMaxImageCount:(NSInteger)MaxImageCount {
    _MaxImageCount = MaxImageCount;
    
    [self prepareImageView];
    [self preparePageControl];
    
    [self setUpTimer];
    
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}


- (void)imageViewDidTap {
    if (self.imageViewDidTapAtIndex != nil) {
        self.imageViewDidTapAtIndex(_currentIndex);
    }
}

+ (instancetype)picScrollViewWithFrame:(CGRect)frame WithImageUrls:(NSArray<NSString *> *)imageUrl {
    return  [[DCPicScrollView alloc] initWithFrame:frame WithImageNames:imageUrl];
}

- (instancetype)initWithFrame:(CGRect)frame WithImageNames:(NSArray<NSString *> *)ImageName {
    
    if (ImageName.count < 1) {
        return nil;
    }else{
        self = [super initWithFrame:frame];
        [self prepareScrollView];
        [self setImageData:ImageName];
        [self setMaxImageCount:_imageData.count];
        
        return self;
    }
    
}
#pragma mark - 播放按钮
-(UIView *)creatPlayView{
    UIView *backView = [[UIView alloc]initWithFrame:FRAME(SCREEN_WIDTH-PX(130), (self.height-PX(82))/2.0, PX(130+40), PX(82))];
    [backView setViewWithRadius:PX(41)];
    backView.backgroundColor = rgba(0, 0, 0, 0.3);
    UIImageView  *playImage = [[UIImageView alloc]initWithFrame:FRAME(PX(4),PX(4) , PX(74), PX(74))];
    [backView setViewWithRadius:PX(37)];
    playImage.image = ImageNamed(@"answer_play_button");
    [backView addSubview:playImage];
    return backView;
}

- (void)prepareScrollView {
    
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:sc];
    
    _scrollView = sc;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(myWidth * 3,0);
    
    _AutoScrollDelay = 2.50f;
    _currentIndex = 0;
}

- (void)prepareImageView {
    
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,myWidth, myHeight)];
    UIImageView *center = [[UIImageView alloc] initWithFrame:CGRectMake(myWidth, 0,myWidth, myHeight)];
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(myWidth * 2, 0,myWidth, myHeight)];
    center.userInteractionEnabled = YES;
    [center addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    
    [_scrollView addSubview:left];
    [_scrollView addSubview:center];
    [_scrollView addSubview:right];
    
    _leftImageView = left;
    _centerImageView = center;
    _rightImageView = right;
    
}

- (void)preparePageControl {
    
    MyPageControl *page = [[MyPageControl alloc] initWithFrame:CGRectMake(0,myHeight - 15,myWidth,  PX(6))];
    
    page.pageIndicatorTintColor =  rgba(255, 255, 255, 0.6);//rgba(255,255,255,0.5);
    page.currentPageIndicatorTintColor = [UIColor whiteColor]; //[UIColor whiteColor];
    page.numberOfPages = _MaxImageCount;
    page.currentPage = 0;
    //    page.hidden = YES;
    [self addSubview:page];
    
    _PageControl = page;
}
#pragma mark-    <--pageControl 位置-->
- (void)setStyle:(PageControlStyle)style {
    if (style == PageControlAtRight) {
        CGFloat w = _MaxImageCount * PX(18)+10;
        _PageControl.frame = CGRectMake(0, 0, w, PX(6));
        _PageControl.center = CGPointMake(myWidth - w/2, myHeight - pageSize+15);
        
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _PageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _PageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setTitleData:(NSArray<NSString *> *)titleData {
    if (titleData.count < 2)  return;
    
    if (titleData.count < _imageData.count) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:titleData];
        for (int i = 0; i < _imageData.count - titleData.count; i++) {
            [temp addObject:@""];
        }
        _titleData = temp;
    }else {
        
        _titleData = titleData;
    }
    
    [self prepareTitleLabel];
    _hasTitle = YES;
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}


- (void)prepareTitleLabel {
    
    [self setStyle:PageControlAtRight];
    
    UIView *left = [self creatLabelBgView];
    UIView *center = [self creatLabelBgView];
    UIView *right = [self creatLabelBgView];
    
    _leftLabel = (UILabel *)left.subviews.lastObject;
    _leftDetail = [self creatLabelDetail:left.bottom];
    //    _leftDetail.frame = FRAME(20, left.bottom,myWidth-20 , pageSize);
    
    _centerLabel = (UILabel *)center.subviews.lastObject;
    _centerDetail = [self creatLabelDetail:center.bottom];
    //    _centerDetail.frame = FRAME(20, center.bottom,myWidth-20 , pageSize);
    
    _rightLabel = (UILabel *)right.subviews.lastObject;
    _rightDetail = [self creatLabelDetail:right.bottom];
    //    _rightDetail.frame = FRAME(20, right.bottom,myWidth-20 , pageSize);
    
    [_leftImageView addSubview:left];
    [_leftImageView addSubview:_leftDetail];
    
    [_centerImageView addSubview:center];
    [_centerImageView addSubview:_centerDetail];
    
    [_rightImageView addSubview:right];
    [_rightImageView addSubview:_rightDetail];
    
    
    _centerPlay = [self creatPlayView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playAction:)];
    [_centerPlay addGestureRecognizer:tap];
    [_centerImageView addSubview:_centerPlay];
    
    
}

-(void)playAction:(UITapGestureRecognizer *)tap{
    NSLog(@"|||--- 点击了第 %@ 图上的播放按钮",@(tap.view.tag));
    if ( self.playBlock) {
        self.playBlock(tap.view.tag);
    }
}
#pragma mark-    <--轮播图内容文字  -->
- (UILabel *)creatLabelDetail:(CGFloat)hightPoint {
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(-20,0, myWidth, pageSize)];// myHeight*146/400
    backV.backgroundColor = COL_BLACK_FONT;
    backV.alpha = 0.2f;
    
    UILabel *label = [[UILabel alloc]initWithFrame: FRAME(10, hightPoint-2,myWidth-20 , 18)];
    label.textAlignment = NSTextAlignmentLeft;
    //    label.numberOfLines = 2;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = FONT_DETAIL;
    label.font = [UIFont italicSystemFontOfSize:PX(26)];
    //    [label addSubview:backV];
    return label;
}
#pragma mark-    <--轮播图标题-->
- (UIView *)creatLabelBgView {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,myHeight-43, myWidth, pageSize)];// myHeight*146/400
    UIImageView *backview = [[UIImageView alloc]initWithFrame:FRAME(0,0, myWidth, 60)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0,0, myWidth, 45);
    gradient.colors = [NSArray arrayWithObjects: (id)RGBA(0,0, 0,0).CGColor, (id)RGBA(0, 0,0,0.5).CGColor,(id)RGBA(0, 0, 0, 0.8).CGColor, nil];
    [backview.layer insertSublayer:gradient atIndex:0];
    
    backview.tag = 100;
    [v addSubview:backview];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,0, myWidth-25,pageSize)];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 2;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = FONT(PX(36));
    [v addSubview:label];
    
    return v;
}

- (void)setTextColor:(UIColor *)textColor {
    _leftLabel.textColor = textColor;
    _rightLabel.textColor = textColor;
    _centerLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font {
    _leftLabel.font = font;
    _rightLabel.font = font;
    _centerLabel.font = font;
}

#pragma mark scrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self changeImageWithOffset:scrollView.contentOffset.x];
}


- (void)changeImageWithOffset:(CGFloat)offsetX {
    
    if (offsetX >= myWidth * 2) {
        _currentIndex++;
        
        if (_currentIndex == _MaxImageCount-1) {
            
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else if (_currentIndex == _MaxImageCount) {
            
            _currentIndex = 0;
            [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
            
        }else {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        _PageControl.currentPage = _currentIndex;
        _centerPlay.tag = _currentIndex;
        
    }
    
    if (offsetX <= 0) {
        _currentIndex--;
        
        if (_currentIndex == 0) {
            
            [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
            
        }else if (_currentIndex == -1) {
            
            _currentIndex = _MaxImageCount-1;
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:0];
            
        }else {
            [self changeImageLeft:_currentIndex-1 center:_currentIndex right:_currentIndex+1];
        }
        
        _PageControl.currentPage = _currentIndex;
        _centerPlay.tag = _currentIndex;
    }
    
}

- (void)changeImageLeft:(NSInteger)LeftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex {
    
    if (_isNetwork) {
        _leftImageView.image = [self setImageWithIndex:LeftIndex];
        _centerImageView.image = [self setImageWithIndex:centerIndex];
        _rightImageView.image = [self setImageWithIndex:rightIndex];
    }else {
        if (_imageData.count > 0) {
            _leftImageView.image = [_imageData objectAtIndexCheck:LeftIndex] == nil ? [_imageData objectAtIndexCheck:LeftIndex] :[self setImageWithIndex:LeftIndex];
            _centerImageView.image = [_imageData objectAtIndexCheck:centerIndex] == nil ? [_imageData objectAtIndexCheck:centerIndex] :[self setImageWithIndex:centerIndex];
            _rightImageView.image = [_imageData objectAtIndexCheck:rightIndex] == nil ? [_imageData objectAtIndexCheck:rightIndex] : [self setImageWithIndex:rightIndex];
        }else{
            _leftImageView.image = [self setImageWithIndex:LeftIndex];
            _centerImageView.image = [self setImageWithIndex:centerIndex];
            _rightImageView.image = [self setImageWithIndex:rightIndex];
        }
    }
    if (_hasTitle) {
        _leftLabel.text = [_titleData objectAtIndexCheck:LeftIndex];
        UIView *leftView  = [_leftImageView viewWithTag:100];
        if ( _leftLabel.text.length >3) {
            leftView.hidden = NO;
        }else{
            leftView.hidden = YES;
        }
        _leftDetail.text = [_detailData objectAtIndexCheck:LeftIndex];
        _centerLabel.text = [_titleData objectAtIndexCheck:centerIndex];
        _centerDetail.text = [_detailData objectAtIndexCheck:centerIndex];
        _rightLabel.text = [_titleData objectAtIndexCheck:rightIndex];
        _rightDetail.text = [_detailData objectAtIndexCheck:rightIndex];
        //        AdsModel *model =  [_modelData objectAtIndexCheck:centerIndex];
        //        if (model.video_url.length > 0 || model.vid.length > 0 ) {
        //            _centerPlay.hidden = NO;
        //        }else{
        _centerPlay.hidden = YES;
        //        }
        UIView *centerView  = [_centerImageView viewWithTag:100];
        if ( _centerLabel.text.length >3) {
            centerView.hidden = NO;
        }else{
            centerView.hidden = YES;
        }
        UIView *rightView  = [_rightImageView viewWithTag:100];
        if ( _rightLabel.text.length >3) {
            rightView.hidden = NO;
        }else{
            rightView.hidden = YES;
        }
        
    }
    
    [_scrollView setContentOffset:CGPointMake(myWidth, 0)];
}

-(void)setPlaceImage:(UIImage *)placeImage {
    _placeImage = placeImage;
    [self changeImageLeft:_MaxImageCount-1 center:0 right:1];
}

- (UIImage *)setImageWithIndex:(NSInteger)index {
    
    //从内存缓存中取,如果没有使用占位图片
    UIImage *image = [[[DCWebImageManager shareManager] webImageCache] valueForKey:[_imageData objectAtIndexCheck:index]];
    
    return image ? image : _placeImage;
}

- (void)scorll {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + myWidth, 0) animated:YES];
}


- (void)setAutoScrollDelay:(NSTimeInterval)AutoScrollDelay {
    _AutoScrollDelay = AutoScrollDelay;
    [self removeTimer];
    [self setUpTimer];
}

- (void)setUpTimer {
    if (_AutoScrollDelay < 0.5) return;
    
    _timer = [NSTimer timerWithTimeInterval:_AutoScrollDelay target:self selector:@selector(scorll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    if (_timer == nil) return;
    [_timer invalidate];
    _timer = nil;
}

- (void)setImageData:(NSArray *)ImageNames {
    
    _isNetwork = [ImageNames.firstObject hasPrefix:@"http://"]  || [ImageNames.firstObject hasPrefix:@"https://"];
    
    if (_isNetwork) {
        
        _imageData = [ImageNames copy];
        
        [self getImage];
        
    }else {
        
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:ImageNames.count];
        
        for (NSString *name in ImageNames) {
            
            [temp addObjectCheck:[UIImage imageNamed:name]];
        }
        
        _imageData = [temp copy];
    }
    
}


- (void)getImage {
    
    for (NSString *urlSting in _imageData) {
        [[DCWebImageManager shareManager] downloadImageWithUrlString:urlSting];
    }
    
}

-(void)dealloc {
    [self removeTimer];
}

//
//- (void)getImage {
//
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//
//    for (NSString *urlString in _imageData) {
//
//        [manager downloadImageWithURL:[NSURL URLWithString:urlString] options:SDWebImageHighPriority progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            if (error) {
//                NSLog(@"%@",error);
//            }
//        }];
//    }
//
//}
//- (UIImage *)setImageWithIndex:(NSInteger)index {
//
//  UIImage *image =
//    [[[SDWebImageManager sharedManager] imageCache] imageFromMemoryCacheForKey:_imageData[index]];
//    if (image) {
//        return image;
//    }else {
//        return _placeImage;
//    }
//
//}
@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

