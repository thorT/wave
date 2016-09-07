//
//  ViewController.m
//  wave
//
//  Created by thor on 16/9/7.
//  Copyright © 2016年 thor. All rights reserved.
//

#import "ViewController.h"
#import "THWave.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    THWave *wave = [[THWave alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
    wave.waveHeight = 8;
    wave.waveSpeed = 10;
    wave.waveWidth = 300;
    wave.waveColor = [UIColor redColor];
    [self.view addSubview:wave];
    
    [wave startWaveAnimation];
    
}






@end
