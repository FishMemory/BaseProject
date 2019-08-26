//
//  IAPService.h
//  WenXiaoYou
//
//  Created by 唐攀 on 2017/4/13.
//  Copyright © 2017年 lantuiOS. All rights reserved.
//

#ifndef IAPService_h
#define IAPService_h

#import <StoreKit/StoreKit.h> 

//内购支付票据
#define PURCHASING @"PURCHASING"
#define PURCHASING_ORDER_ID @"PURCHASING_ORDERID"
//商品内购存储
#define IAP_PRODUCTS_KEY @"IAP_PRODUCTS_KEY"
// 内购 成功 通知
#define NOTIFACTION_IAP_KEY  @"notifaction_iap_pay_key"
@protocol IAPDelegate <NSObject>
-(void)payfinished;
@end
@interface IAPService : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
// MichaelTang add to save orderId
@property (strong, nonatomic) NSString *orderId;
-(SKProduct*)getProductByPID:(NSString *)pid;
-(void)buyProductByPID:(NSString *)pid orderId:(NSString*) orderId;
-(void)getProductInfo;
+(IAPService *)sharedManager;
@end


#endif /* IAPService_h */
