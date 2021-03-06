//
//  ViewController.m
//  WTWeakTimerDemo
//
//  Created by liuyuning on 2017/9/15.
//  Copyright © 2017年 liuyuning. All rights reserved.
//

#import "ViewController.h"
#import "WTWeakTimer.h"
#import "MYViewController.h"

@interface ViewController () {
    NSTimer *_timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionTimer:(NSTimer *)timer {
    NSLog(@"actionTimer:%@", timer.userInfo);
}

- (IBAction)actionTest1:(id)sender {
    NSLog(@"Test 1");
    WTWeakTimer *weakTimer = [[WTWeakTimer alloc] initWithTimeInterval:10 target:self selector:@selector(actionTimer:) userInfo:@"Test1-1" repeats:YES];
    _timer = weakTimer.timer;
    
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:10 weakTarget:self selector:@selector(actionTimer:) userInfo:@"Test1-2" repeats:YES];
    
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:10 weakTarget:self selector:@selector(actionTimer:) userInfo:@"Test1-3" repeats:YES];
}

- (IBAction)actionTest2:(id)sender {
    NSLog(@"Test 2");
    [NSTimer scheduledTimerWithTimeInterval:10 weakTarget:self selector:@selector(actionTimer:) userInfo:@"Test2-1" repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:12 weakTarget:self selector:@selector(actionTimer:) userInfo:@"Test2-2" repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:14 weakTarget:self selector:@selector(actionTimer:) userInfo:@"Test2-3" repeats:YES];
}

- (IBAction)actionTest3:(id)sender {
    NSLog(@"Test 3");
    [NSTimer scheduledTimerWithTimeInterval:10 weakTarget:self selector:@selector(actionTimer:) userInfo:@"Test3-1" repeats:NO];
}


- (IBAction)actionTestVC:(id)sender {
    NSLog(@"Test VC");
    MYViewController *mvc = [[MYViewController alloc] init];
    [self presentViewController:mvc animated:YES completion:nil];
}
@end
