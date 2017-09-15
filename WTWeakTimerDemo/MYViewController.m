//
//  MYViewController.m
//  TestTimer
//
//  Created by liuyuning on 2017/8/28.
//  Copyright © 2017年 liuyuning. All rights reserved.
//

#import "MYViewController.h"
#import "WTWeakTimer.h"

@interface MYViewController () {
    NSTimer *_timer;
}
@end

@implementation MYViewController
- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"消失" forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 30, 80, 40);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(actionDismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:10 weakTarget:self selector:@selector(timerFire:) userInfo:@"TestVC-1" repeats:YES];
    _timer = [NSTimer scheduledTimerWithTimeInterval:12 weakTarget:self selector:@selector(timerFire:) userInfo:@"TestVC-2" repeats:YES];
    _timer = [NSTimer scheduledTimerWithTimeInterval:14 weakTarget:self selector:@selector(timerFire:) userInfo:@"TestVC-3" repeats:YES];
}

- (void)timerFire:(NSTimer *)timer {
    NSLog(@"timerFire:%@", timer.userInfo);
}

- (void)actionDismiss {
    NSLog(@"actionDismiss:%@", _timer);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
