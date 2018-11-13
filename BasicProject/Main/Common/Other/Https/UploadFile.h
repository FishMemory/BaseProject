//
//  UploadFile.h
//   
//
//  Created by 唐攀 on 2017/2/9.
//  Copyright © 2017年  . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadFile : NSObject
+ (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data dir:(NSString*)dname;
@end
