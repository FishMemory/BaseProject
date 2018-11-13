//
//  UIButton+singleSelect.m
//   
//
//  Created by   on 16/3/25.
//  Copyright © 2016年  . All rights reserved.
//
#import <objc/runtime.h>
#import "UIButton+singleSelect.h"
static NSString *isclickedKey = @"isclicked";

@implementation UIButton (singleSelect)


-(BOOL)isclicked{
    return objc_getAssociatedObject(self, &isclickedKey);
}

-(void)setIsclicked:(BOOL)isclicked{
    objc_setAssociatedObject(self, &isclickedKey, @(isclicked), OBJC_ASSOCIATION_ASSIGN);
}
@end
