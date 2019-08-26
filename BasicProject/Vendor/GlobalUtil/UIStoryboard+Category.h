//
//  UIStoryboard+Category.h
//  JZFW_Personal
//
//  Created by 宋亚清 on 2019/4/25.
//  Copyright © 2019 ZJWL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIStoryboard (Category)
+(id)initaVCWithName:(NSString*)name Identifier:(NSString*)storyboardID;
+(id)initaVCWithName:(NSString*)name;
@end

NS_ASSUME_NONNULL_END
