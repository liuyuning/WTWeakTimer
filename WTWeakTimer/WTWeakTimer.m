//
//  WTWeakTimer.m
//  WTWeakTimer
//
//  Created by liuyuning on 2017/8/28.
//  Copyright © 2017年 liuyuning. All rights reserved.
//

#import "WTWeakTimer.h"
#import <objc/runtime.h>

#define PRINT_LOG 0

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface WTWeakTimerObserver : NSObject {
    __weak id _target;
    SEL _selector;
}
@end

@implementation WTWeakTimerObserver
- (instancetype)initWithtarget:(id)target selector:(SEL)sel {
    self = [super init];
    if (self) {
        _target = target;
        _selector = sel;
    }
    return self;
}

- (void)dealloc {
#if PRINT_LOG
    NSLog(@"%s", __func__);
#endif
    if (_target && [_target respondsToSelector:_selector]) {
        [_target performSelector:_selector withObject:self];
    }
}
@end


@implementation WTWeakTimer {
    NSString *_key;
    __weak id _target;
    SEL _selector;
}

- (void)dealloc {
#if PRINT_LOG
    NSLog(@"%s", __func__);
#endif
    objc_setAssociatedObject(_target, _key.UTF8String, nil, OBJC_ASSOCIATION_RETAIN);
}

- (instancetype)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    self = [super init];
    if (self) {
        if (aTarget && aSelector) {
            _target = aTarget;
            _selector = aSelector;
            _timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(actionTimer:) userInfo:userInfo repeats:yesOrNo];
            
            WTWeakTimerObserver *observer = [[WTWeakTimerObserver alloc] initWithtarget:self selector:@selector(observerDealloc)];
            _key = [NSString stringWithFormat:@"WTWeakTimer-%p",observer];
            objc_setAssociatedObject(_target, _key.UTF8String, observer, OBJC_ASSOCIATION_RETAIN);
        }
    }
    return self;
}

- (void)observerDealloc {
    [_timer invalidate];
}

- (void)actionTimer:(NSTimer *)timer {
#if PRINT_LOG
    NSLog(@"%s:%@", __func__, timer.userInfo);
#endif
    if (_target) {
        if ([_target respondsToSelector:_selector]) {
            [_target performSelector:_selector withObject:timer];
        }
    } else {
        [timer invalidate];
    }
}
@end


@implementation NSTimer(WeakTimer)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti weakTarget:(id)weakTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    WTWeakTimer *weakTimer = [[WTWeakTimer alloc] initWithTimeInterval:ti target:weakTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    return weakTimer.timer;
}
@end

#pragma clang diagnostic pop
