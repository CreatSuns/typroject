//
//  NSObject+TyObject.m
//  TyLiving
//
//  Created by 李世航 on 2020/9/15.
//  Copyright © 2020 李世航. All rights reserved.
//

#import "NSObject+TyObject.h"

@implementation NSObject (TyObject)

- (id)obj{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setObj:(id)obj{
    objc_setAssociatedObject(self, @selector(obj), obj, OBJC_ASSOCIATION_ASSIGN);
}

@end
