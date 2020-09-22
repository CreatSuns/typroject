//
//  TyPayServices.m
//  TyLiving
//
//  Created by 李世航 on 2020/9/9.
//  Copyright © 2020 李世航. All rights reserved.
//

#import "TyPayServices.h"

@implementation TyPayServices

+ (void)aliPayWithOrderString:(NSString *)orderString Sign:(NSString *)sign callback:(void(^)(NSDictionary *resultDic))callback{
    NSString * appScheme = @"tyalipay";

    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString * order = [NSString stringWithFormat:@"%@&sign=%@", orderString, sign];

    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:order fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        callback(resultDic);
    }];
}

@end
