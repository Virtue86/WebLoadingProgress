//
//  NSTimer+addition.m
//  tangtang
//
//  Created by virtue on 2018/3/3.
//  Copyright © 2018年 none. All rights reserved.
//

#import "NSTimer+addition.h"

@implementation NSTimer (addition)
- (void)pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

@end
