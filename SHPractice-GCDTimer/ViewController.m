//
//  ViewController.m
//  SHPractice-GCDTimer
//
//  Created by shine on 2018/6/8.
//  Copyright © 2018 shine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startEvent:(id)sender {
    [self createTimer];
}


- (IBAction)stopEvent:(id)sender {
    
}


- (void)createTimer{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_async(dispatch_queue_create("com.test.demo", DISPATCH_QUEUE_CONCURRENT), ^{
            NSTimer *timer = [NSTimer timerWithTimeInterval:0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        });
    });
}

- (void)updateTimer{
    NSLog(@"currentThread -------- %@", [NSThread currentThread]);
}

@end
