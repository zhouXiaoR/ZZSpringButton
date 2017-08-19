//
//  NSURLSessionDataTask+reCount.m
//  MPUpSpringDemo
//
//  Created by 周晓瑞 on 2017/4/1.
//  Copyright © 2017年 colleny. All rights reserved.
//

#import "NSURLSessionDataTask+reCount.h"
#import <objc/runtime.h>

char abKey;

@implementation NSURLSessionDataTask (reCount)

-(void)setNetXXCount:(NSInteger)netXXCount{
    objc_setAssociatedObject(self, &abKey,[NSNumber numberWithInteger:netXXCount], OBJC_ASSOCIATION_ASSIGN);
    
}
-(NSInteger)netXXCount{
    return   [objc_getAssociatedObject(self, &abKey) integerValue];
}


@end
