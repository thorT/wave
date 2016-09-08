# 使用贝塞尔曲线绘制水波纹

示例：

![](https://github.com/thorT/wave/blob/master/screenshot/Untitled.gif)

---
### 思路： 使用**贝塞尔曲线**绘制正弦曲线；使用**CAShapeLayer**绘制形状；使用CADisplayLink做刷屏；下面直接上代码；

###### 一. 创建THWave类，继承于UIView
<pre>
//外放这些属性和方法
/** 浪宽： 一个完整的浪的宽度 */
@property (nonatomic, assign) CGFloat waveWidth;

/** 浪高： 波峰到波谷的距离 */
@property (nonatomic, assign) CGFloat waveHeight;

/** 浪速： 浪的移动速度 */
@property (nonatomic, assign) CGFloat waveSpeed;

/** 浪速： 浪的内填充颜色 */
@property (nonatomic, strong) UIColor *waveColor;

/** 返回浪的Y点 */
@property (nonatomic, copy) WaveYBlock waveY;


/** 开始波动 */
- (void)startWaveAnimation;
/** 结束波动 */
- (void)endWaveAnimation;
</pre>
###### 二. 创建CAShapeLayer
<pre>
#pragma mark - initUI
- (void)initUI{
    // 设置底色
    self.backgroundColor = [UIColor whiteColor];
    
    // 创建layer
    _waveLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_waveLayer];
}

#pragma mark - 设置浪高
- (void)setWaveHeight:(CGFloat)waveHeight{
    _waveHeight = waveHeight;
    
    CGRect frame = self.bounds;
    frame.origin.y = frame.size.height - self.waveHeight;
    frame.size.height = self.waveHeight;
    _waveLayer.frame = frame;
    
}
#pragma mark - 设置浪色
- (void)setWaveColor:(UIColor *)waveColor{
    _waveColor = waveColor;
    _waveLayer.fillColor = waveColor.CGColor;
}
</pre>
###### 三. 创建刷屏器
<pre>
#pragma mark - 开始和结束动画
- (void)startWaveAnimation{
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)endWaveAnimation{
    [self.timer invalidate];
    self.timer = nil;
}
</pre>
###### 四. 绘制
<pre>
// 动画实现
- (void)wave{
    
    // 1. 随机
    int speed = [@(self.waveSpeed) intValue];
    int num = arc4random() % speed;
    self.offset += num;
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.waveHeight;
    CGFloat y = 0.f;
    // 2. 绘线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, height)];
    for (CGFloat x = 0.f; x <= width; x++) {
        y = height * sinf(2*M_PI/self.waveWidth *x - self.offset * 0.0045);
        [path addLineToPoint:CGPointMake(x, y)];
    }
    
    // 3. 返回x等于中心点时的Y值
    CGFloat centerX = self.bounds.size.width / 2.0;
    CGFloat centerY = height * sinf(2*M_PI/self.waveWidth * centerX - self.offset * 0.0045);
    if (self.waveY) {
        self.waveY(centerY);
    }
    
    // 4. 闭合曲线
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(0, height)];
    [path closePath];
    self.waveLayer.path = path.CGPath;
}
</pre>

###### 五. 外部引用,顺便加条小船
<pre>
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
        __weak typeof(wave)weakWave = wave;
        wave.waveY = ^(CGFloat waveY){
            CGRect frame = boat.bounds;
            frame.origin.x = CGRectGetWidth(weakSelf.view.frame)/2.0 - CGRectGetWidth(frame)/2.0;
            frame.origin.y = weakWave.bounds.size.height - boat.bounds.size.height - weakWave.waveHeight + waveY;
            boat.frame = frame;
        };
        [wave startWaveAnimation];
        wave;
    })];
}
</pre>

大功告成！！！



