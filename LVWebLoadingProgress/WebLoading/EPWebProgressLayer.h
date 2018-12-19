//
//  EPWebProgressLayer.h
//  tangtang
//
//  Created by virtue on 2018/3/3.
//  Copyright © 2018年 none. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface EPWebProgressLayer : CAShapeLayer
- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;
@end
