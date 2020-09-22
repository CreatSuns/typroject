//
//  TyPayServices.h
//  TyLiving
//
//  Created by 李世航 on 2020/9/9.
//  Copyright © 2020 李世航. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TyPayServices : NSObject
+ (void)aliPayWithOrderString:(NSString *)orderString Sign:(NSString *)sign callback:(void(^)(NSDictionary *resultDic))callback;
@end

NS_ASSUME_NONNULL_END
