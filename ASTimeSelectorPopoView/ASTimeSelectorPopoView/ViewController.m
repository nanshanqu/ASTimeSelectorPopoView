//
//  ViewController.m
//  ASTimeSelectorPopoView
//
//  Created by Mac on 2020/6/30.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ViewController.h"
#import "ASTimeSelectorPopoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [ASTimeSelectorPopoView showTimeSelectorPopoViewWithSelectedTimeOperation:^(NSString * _Nonnull selectedTime) {

        NSLog(@"selectedTime:%@", selectedTime);
    }];
    
}


@end
