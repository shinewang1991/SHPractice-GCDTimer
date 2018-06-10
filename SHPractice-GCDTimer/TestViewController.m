//
//  TestViewController.m
//  SHPractice-GCDTimer
//
//  Created by Shine on 10/06/2018.
//  Copyright © 2018 shine. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSThread *timerThread;
@end

@implementation TestViewController

- (void)dealloc{
    NSLog(@"dealloc called");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startEvent:(id)sender {
    [self createTimer];
}


- (IBAction)stopEvent:(id)sender {
    if(self.timerThread){
        [self performSelector:@selector(stopTimer) onThread:self.timerThread withObject:nil waitUntilDone:NO];
    }
//    [self stopTimer];
}


- (void)createTimer{
    static dispatch_once_t onceToken;
    __weak typeof(self) weakSelf = self;
    dispatch_once(&onceToken, ^{
        dispatch_async(dispatch_queue_create("com.test.demo", DISPATCH_QUEUE_CONCURRENT), ^{
            weakSelf.timerThread = [NSThread currentThread];
            weakSelf.timerThread.name = @"createTimerThraed";
            weakSelf.timer = [NSTimer timerWithTimeInterval:3 target:weakSelf selector:@selector(updateTimer) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
            [[NSRunLoop currentRunLoop] run];
        });
    });
}

- (void)updateTimer{
    NSLog(@"currentThread -------- %@", [NSThread currentThread]);
}

- (void)stopTimer{
    NSLog(@"stopTimerThread -------- %@", [NSThread currentThread]);
    if(self.timer.isValid){
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
