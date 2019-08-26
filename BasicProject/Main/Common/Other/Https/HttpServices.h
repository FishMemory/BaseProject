//
//  HttpServes.h
//
//
//  Created by 宋亚清 on 16/3/4.
//  Copyright © 2016年  . All rights reserved.
//

#import "AFSecurityPolicy.h"


// 过期
#define Deprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)


@interface Pagination : NSObject
/** 当前页码 */
@property (nonatomic,assign) NSInteger currentPageNumber;

/** 共多少页 */
@property (nonatomic,assign) NSInteger totalPageCount;

/** 每页多少数据量 */
@property (nonatomic,assign) NSInteger countPerPage;

/** 共多少数据 */
@property (nonatomic,assign) NSInteger totalDataCount;

/** 分页URL前缀 */
@property (nonatomic,strong) NSString  *baseUrl;

/** 获得指定页码的URL */
-(NSString*)getPageUrl:(NSInteger)pageNumber;

@end


/** API v1回调成功的方法 */
typedef void (^SuccessBlock)(id jsonObj);
/** 接口调用失败回调 */
typedef void (^APIErrorBlock)(id jsonObj);
/** 网络失败回调 */
typedef void (^ErrorBlock)(NSURLSessionDataTask *operation,NSError *error);


// API v2回调成功的方法
typedef void (^Success)(id jsonObj);

@interface HttpServices : NSObject

+ (AFSecurityPolicy*)sharedSecurityPolicy;

// ------------------------- New RESTful API ---------------------------
+(void)get:(NSString*)url showBackProgressHD:(BOOL)show showError:(BOOL)showErrorToast success:(Success)success networkErroBlock:(ErrorBlock)networkError;

+(void)post:(NSString*)url showBackProgressHD:(BOOL)show showError:(BOOL)showErrorToast dataDic:(NSDictionary*)dataDic
    success:(Success)success networkErroBlock:(ErrorBlock)networkError;

//我的shop编辑商品post请求,传参数array
+(void)shopPost:(NSString*)url  showBackProgressHD:(BOOL)show  showError:(BOOL)showErrorToast dataDic:(id)dataDic
        success:(Success)success networkErroBlock:(ErrorBlock)networkError;

+ (void)postNetworkDataSuccess:(Success)success failure:(ErrorBlock)failure withUrl:(NSString *)urlStr withParameters:(NSDictionary *)dict;


+(void)uploadFile:(NSData*)data upLoadUrl:(NSString*)upLoadUrl success:(SuccessBlock)sucess failed:(APIErrorBlock)failed;


+(void)uploadFileWithFormat:(NSData*)data format:(NSString *)suffix success:(SuccessBlock)sucess failed:(APIErrorBlock)failed;


// 多图上传
+(void)startMultiPartUploadTaskWithURL:(NSString *)url imagesArray:(NSArray *)images compressionRatio:(float)ratio succeedBlock:(void (^)(NSDictionary *dict))succeedBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end
