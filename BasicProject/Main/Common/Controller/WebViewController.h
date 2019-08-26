//
//  WebViewController
//   
//
//  Created by 宋亚清 on 16/4/11.
//  Copyright © 2016年  . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : BaseController <UIWebViewDelegate>
@property (strong, nonatomic) NSString  *webURl;/**< 网址链接 >*/
@property (strong, nonatomic) NSString *navTitle;
@property (assign, nonatomic) BOOL navigationItemTransparent; /**< 是否设置导航透明 >*/
@end
