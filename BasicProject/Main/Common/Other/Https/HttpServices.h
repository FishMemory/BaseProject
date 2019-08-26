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
typedef void (^Success)(id jsonObj, Pagination* page);

@interface HttpServices : NSObject

+ (AFSecurityPolicy*)sharedSecurityPolicy;

// ------------------------- New RESTful API ---------------------------

/**
 * 基于RESTful的GET请求
 * 用于获取API信息
 * 分页信息保存在success()中的page参数里
 *  @param url       网址URL
 *  @param show      是否显示loading
 *  @param token     用户登录token，不需要可以传nil
 *  @param success api调用成功后回调方法
 *  @param apiErroBlock api调用失败之后 回调方法
 *  @param networkErroBlock   错误之后 回调
 */
+(void)get:(NSString*)url _id:(NSNumber*)_id showBackProgressHD:(BOOL)show token:(NSString*)token showError:(BOOL)showErrorToast
   success:(Success)success
apiErroBlock:(APIErrorBlock)apiError
networkErroBlock:(ErrorBlock)networkError;

/**
 * 基于RESTful的post请求
 * 用于向API里添加数据
 *  @param url       网址URL
 *  @param show      是否显示loading
 *  @param token     用户登录token，不需要可以传nil
 *  @param dataDic   请求的参数
 *  @param success api调用成功后回调方法
 *  @param apiErroBlock api调用失败之后 回调方法
 *  @param networkErroBlock   错误之后 回调
 */
+(void)post:(NSString*)url _id:(NSNumber*)_id showBackProgressHD:(BOOL)show token:(NSString*)token showError:(BOOL)showErrorToast dataDic:(NSDictionary*)dataDic
    success:(Success)success
apiErroBlock:(APIErrorBlock)apiError
networkErroBlock:(ErrorBlock)networkError;

/**
 * 基于RESTful的put请求
 * 用于更新API数据信息
 *  @param url       网址URL
 *  @param show      是否显示loading
 *  @param token     用户登录token，不需要可以传nil
 *  @param dataDic   请求的参数
 *  @parm  paramete  URL 拼接参数 可为空
 *  @param success api调用成功后回调方法
 *  @param apiErroBlock api调用失败之后 回调方法
 *  @param networkErroBlock   错误之后 回调
 */
+(void)put:(NSString*)url _id:(NSNumber*)_id showBackProgressHD:(BOOL)show paramete:(NSString *)paramete token:(NSString*)token  showError:(BOOL)showErrorToast dataDic:(NSDictionary*)dataDic
   success:(Success)success
apiErroBlock:(APIErrorBlock)apiError
networkErroBlock:(ErrorBlock)networkError;

/**
 * 基于RESTful的GET请求
 * 用于删除API指定的数据
 *  @param url       网址URL
 *  @param show      是否显示loading
 *  @param token     用户登录token，不需要可以传nil
 *  @param success api调用成功后回调方法
 *  @param apiErroBlock api调用失败之后 回调方法
 *  @param networkErroBlock   错误之后 回调
 */

+(void)restDelete:(NSString*)url _id:(NSNumber*)_id showBackProgressHD:(BOOL)show token:(NSString*)token showError:(BOOL)showErrorToast
success:(Success)success
apiErroBlock:(APIErrorBlock)apiError
networkErroBlock:(ErrorBlock)networkError;


+(void)uploadFile:(NSData*)data upLoadUrl:(NSString*)upLoadUrl success:(SuccessBlock)sucess failed:(APIErrorBlock)failed;
//+(void)uploadFile:(NSData*)data success:(SuccessBlock)sucess failed:(APIErrorBlock)failed;


+(void)uploadFileWithFormat:(NSData*)data format:(NSString *)suffix success:(SuccessBlock)sucess failed:(APIErrorBlock)failed;


// 多图上传
+(void)startMultiPartUploadTaskWithURL:(NSString *)url imagesArray:(NSArray *)images compressionRatio:(float)ratio succeedBlock:(void (^)(NSDictionary *dict))succeedBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end
