//
//  NextViewController.m
//  wave
//
//  Created by thor on 16/9/8.
//  Copyright © 2016年 thor. All rights reserved.
//

#import "NextViewController.h"

#import "THWave.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 背景色
    self.view.backgroundColor = [UIColor colorWithRed:48/255.0 green:204/255.0 blue:249/255.0 alpha:1];
    
    // 2. 创建浪
    [self creatWave];
}

#pragma mark - creatWave
-(void)creatWave{
    // 1. view 增加浪
    [self.view addSubview: ({
        THWave *wave = [[THWave alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
        wave.waveHeight = 18;
        wave.waveSpeed = 15;
        wave.waveWidth = 300;
        wave.waveColor = [UIColor colorWithRed:48/255.0 green:204/255.0 blue:249/255.0 alpha:1];
        
        // 2. 浪增加船
        UIImageView *boat;
        [wave addSubview:({
            boat = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boat"]];
            boat.bounds = CGRectMake(0, 0, 123.3, 106.6);
            boat.contentMode = UIViewContentModeScaleToFill;
            boat;
        })];
       
        // 3. 弱化，调整船的位置
        __weak typeof(self)weakSelf = self;
        wave.waveY = ^(CGFloat waveY){
            CGRect frame = boat.bounds;
            frame.origin.x = CGRectGetWidth(weakSelf.view.frame)/2.0 - CGRectGetWidth(frame)/2.0;
            frame.origin.y = wave.bounds.size.height - boat.bounds.size.height - wave.waveHeight + waveY;
            boat.frame = frame;
        };
        [wave startWaveAnimation];
        wave;
    })];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
    NSLog(@"视图被销毁了");
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
