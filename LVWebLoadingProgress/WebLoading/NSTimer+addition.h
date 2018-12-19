//
//  NSTimer+addition.h
//  tangtang
//
//  Created by virtue on 2018/3/3.
//  Copyright © 2018年 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (addition)

- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;
@end
