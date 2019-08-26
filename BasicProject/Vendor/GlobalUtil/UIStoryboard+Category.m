//
//  UIStoryboard+Category.m
//  JZFW_Personal
//
//  Created by 宋亚清 on 2019/4/25.
//  Copyright © 2019 ZJWL. All rights reserved.
//

#import "UIStoryboard+Category.h"

@implementation UIStoryboard (Category)
+(id)initaVCWithName:(NSString*)name Identifier:(NSString*)storyboardID{
    UIStoryboard *board = [UIStoryboard storyboardWithName:name bundle:nil];
    return [board instantiateViewControllerWithIdentifier:storyboardID];
}
+(id)initaVCWithName:(NSString*)name  {
    UIStoryboard *board = [UIStoryboard storyboardWithName:name bundle:nil];
    return [board instantiateInitialViewController];
}
@end
