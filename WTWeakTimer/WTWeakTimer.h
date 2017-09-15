//
//  WTWeakTimer.h
//  WTWeakTimer
//
//  Created by liuyuning on 2017/8/28.
//  Copyright © 2017年 liuyuning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTWeakTimer : NSObject
@property (nonatomic, strong, readonly)NSTimer *timer;
- (instancetype)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
@end


@interface NSTimer(WeakTimer)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti weakTarget:(id)weakTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
@end
