//
//  IAPService.m
//  WenXiaoYou
//
//  Created by 宋亚清 on 2017/4/13.
//  Copyright © 2017年 lantuiOS. All rights reserved.
//

#import "IAPService.h"

@interface IAPService (){
    NSMutableDictionary *productDic;
}
@end

@implementation IAPService

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self getProductInfo];
    }
    return self;
}

-(void)getProductInfo
{
    // --------- IAP ---------验证产品ID
    productDic = [[NSMutableDictionary alloc]initWithCapacity:1];
    NSMutableArray * prodArray = [[NSMutableArray alloc]initWithObjects:@"cid198_001",@"cid198_002",@"cid198_003",@"cid198_004",@"cid198_005",@"cid198_006",@"cid198_007",@"cid198_008",@"cid198_009",@"cid198_010", nil];
    NSSet *productIDs = [NSSet setWithArray:prodArray];
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:productIDs];
    request.delegate = self;
    [request start];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    NSString *base64String = GET_OBJ_FROM_USER_DEFAULT(PURCHASING);
    if (base64String) {
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    }
    
    //    [HttpServices get:iap_products _id:nil showBackProgressHD:YES token:APP.token showError:YES success:^(id jsonObj, Pagination *page) {
    //        NSArray  *dataList = [jsonObj objectForKeyCheck:@"data"];
    //        SAVE_TO_USER_DEFAULT(dataList, IAP_PRODUCTS_KEY);
    //        for (NSDictionary *dic  in dataList) {
    //            NSString *pid  = [dic objectForKeyCheck:@"pid"];
    //            [prodArray addObject:pid];
    //        }
    //        NSSet *productIDs = [NSSet setWithArray:prodArray];
    //        SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:productIDs];
    //        request.delegate = self;
    //        [request start];
    //
    //        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    //        NSString *base64String = GET_OBJ_FROM_USER_DEFAULT(PURCHASING);
    //        if (base64String) {
    //            [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    //        }
    //
    //    } apiErroBlock:^(id jsonObj) {
    //
    //    } networkErroBlock:^(NSURLSessionDataTask *operation, NSError *error) {
    //
    //    }];
    //
    // ---------- IAP ---------
}

+ (IAPService *)sharedManager {
    //它还接收一个希望在应用的生命周期内仅被调度一次的代码块，对于本例就用于shared实例的实例化。
    //  dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如
    static dispatch_once_t onceQueue;
    static IAPService *appInstance;
    dispatch_once(&onceQueue, ^{
        appInstance = [[IAPService alloc] init];
    });
    return appInstance;
}

-(SKProduct*)getProductByPID:(NSString *)pid
{
    NSDictionary * dic = productDic;
    if([dic count] > 0){
        return [dic objectForKey:pid];
    }else{
        // 重新获得商品信息
        [self getProductInfo];
    }
    return nil;
}

-(void)buyProductByPID:(NSString *)pid orderId:(NSString*) orderId
{
    [[ProgressHUD instance] showBackProgressHD:YES inView:APP.window info:@""];
    SKProduct * prod = [self getProductByPID:pid];
    // save
    self.orderId = orderId;
    if(prod){
        SKPayment *payment = [SKPayment paymentWithProduct:prod];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

#pragma IAP购买回调
- (void)paymentQueue:(SKPaymentQueue *)queue  updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
                // Call the appropriate custom method for the transaction state.
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"正在购买");
                
                break;
            case SKPaymentTransactionStateDeferred:
                NSLog(@"中止购买");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"购买失败：%@", transaction.error);
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
                break;
            case SKPaymentTransactionStatePurchased:
            {
                [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
                NSString *base64String = [transaction.transactionReceipt base64EncodedStringWithOptions:0];
                NSLog(@"购买成功, 收据:%@", base64String);
                // 保存票据和订单号
                SAVE_TO_USER_DEFAULT(base64String, PURCHASING);
                self.orderId = self.orderId.length > 0 ? self.orderId : @"";
                SAVE_TO_USER_DEFAULT(self.orderId, PURCHASING_ORDER_ID);
                NSDictionary *dic = @{@"xtag":self.orderId,  @"ytag":base64String};
                NSLog(@">>> %@", dic);
                // 上传票据
                [HttpServices post:nil showBackProgressHD:YES showError:YES dataDic:nil
                           success:^(id jsonObj) {
                               // 删除票据和订单
                               REMOVE_USER_DEFAULT(PURCHASING);
                               REMOVE_USER_DEFAULT(PURCHASING_ORDER_ID);
                               [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFACTION_IAP_KEY object:nil];
                               [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                               
                           } networkErroBlock:^(NSURLSessionDataTask *operation, NSError *error) {
                               [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                           }];
                break;
            }
            case SKPaymentTransactionStateRestored:
                NSLog(@"购买restored:%@", transaction);
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
                break;
            default:
                // For debugging
                NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
                [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
                break;
        }
    }
}

-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"paymentQueueRestoreCompletedTransactionsFinished");
    [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
}

-(void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"restoreCompletedTransactionsFailedWithError");
    [[ProgressHUD instance] showBackProgressHD:NO inView:APP.window info:@""];
}
#pragma IAP验证产品ID请求回调
- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *myProducts = response.products;
    for (SKProduct *product in myProducts)
    {
        //product
        NSLog(@"id：%@", product.productIdentifier);
        NSLog(@"描述：%@", product.localizedDescription);
        NSLog(@"标题：%@", product.localizedTitle);
        NSLog(@"价格：%@", product.price);
        NSLog(@"本地价格：%@", product.priceLocale);
        [productDic setObject:product forKey:product.productIdentifier];
    }
}

#pragma IAP验证产品ID请求回调
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    //处理错误
}
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
@end
