//
//  THWave.h
//  wave
//
//  Created by thor on 16/9/7.
//  Copyright © 2016年 thor. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface THWave : UIView

/** 浪宽： 一个完整的浪的宽度 */
@property (nonatomic, assign) CGFloat waveWidth;

/** 浪高： 波峰到波谷的距离 */
@property (nonatomic, assign) CGFloat waveHeight;

/** 浪速： 浪的移动速度 */
@property (nonatomic, assign) CGFloat waveSpeed;

/** 浪速： 浪的内填充颜色 */
@property (nonatomic, strong) UIColor *waveColor;


/** 开始波动 */
- (void)startWaveAnimation;
/** 结束波动 */
- (void)endWaveAnimation;


@end






