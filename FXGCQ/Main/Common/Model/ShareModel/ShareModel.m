//
//  ShareModel.m
//  WenXiaoYou
//
//  Created by 宋亚清 on 16/6/26.
//  Copyright © 2016年 lantuiOS. All rights reserved.
//

#import "ShareModel.h"

@implementation ShareModel
-(instancetype)init{
    if ([super init]) {
        self.title = @"";
        self.shareUrl = @"";
        self.share = 0;
        self.desc = @"";
    }
    return self;
}
@end
