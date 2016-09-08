//
//  ViewController.m
//  wave
//
//  Created by thor on 16/9/7.
//  Copyright © 2016年 thor. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"



@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)sail:(UIButton *)sender {
    NextViewController *next = [[NextViewController alloc] init];
    [self presentViewController:next animated:YES completion:nil];
    
}




@end
