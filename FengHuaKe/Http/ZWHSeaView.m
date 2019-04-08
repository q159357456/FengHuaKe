//
//  ZWHSeaView.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/12.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHSeaView.h"

@interface ZWHSeaView()

@property(nonatomic,strong)CAShapeLayer *frontWaveLayer;
@property(nonatomic,strong)CAShapeLayer *insideWaveLayer;

@property(nonatomic,strong)CAShapeLayer *secondWaveLayer;


@property(nonatomic,strong)CADisplayLink *waveDisplayLink;

@end

@implementation ZWHSeaView

{
    CGFloat waveWidth;
    CGFloat waveHeight;
    
    CGFloat waveA;      // A
    CGFloat waveW;      // ω
    CGFloat offsetF;    // φ firstLayer
    CGFloat offsetS;    // φ secondLayer
    CGFloat currentK;   // k
    CGFloat waveSpeedF; // 外层波形移动速度
    CGFloat waveSpeedS; // 内层波形移动速度
    
    WaveDirectionType direction; //移动方向
}



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self configWaveProperties];
        [self createWaves];
        _waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshCurrentWave:)];
        [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    return self;
}

-(void)refreshCurrentWave:(CADisplayLink *)displayLink
{
    offsetF += waveSpeedF * direction; //direction为枚举值，正向为-1，逆向为1，通过改变符号改变曲线的移动方向
    offsetS += waveSpeedS * direction;
    
    //将之前创建曲线的方法移到这里
    [self drawCurrentWaveWithLayer:_frontWaveLayer offset:offsetF];
    [self drawCurrentWaveWithLayer:_insideWaveLayer offset:offsetS];
    //[self drawCurrentWaveWithLayer:_secondWaveLayer offset:offsetF + M_PI/2];
}


-(void)configWaveProperties
{
    _frontColor    = [UIColor blackColor];
    _insideColor   = [UIColor grayColor];
    _frontSpeed    = 0.1;
    _insideSpeed   = 0.1;
    _waveOffset    = M_PI;
    _directionType = WaveDirectionTypeBackWard;
}

-(void)createWaves
{
    waveWidth   = self.frame.size.width;
    waveHeight  = self.frame.size.height;
    
    waveA       = waveHeight/2;
    waveW       = (M_PI * 2 / waveWidth)*1.5;
    offsetF     = 0;
    offsetS     = offsetF + _waveOffset;
    currentK    = waveHeight / 2;
    waveSpeedF  = _frontSpeed;
    waveSpeedS  = _insideSpeed;
    direction   = _directionType;
    
    _frontWaveLayer = [CAShapeLayer layer];
    _frontWaveLayer.fillColor = _frontColor.CGColor; //设置填充颜色
    [self.layer addSublayer:_frontWaveLayer];
    
    _insideWaveLayer = [CAShapeLayer layer];
    _insideWaveLayer.fillColor = _insideColor.CGColor;
    [self.layer insertSublayer:_insideWaveLayer below:_frontWaveLayer];
    
    _secondWaveLayer = [CAShapeLayer layer];
    _secondWaveLayer.fillColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    [self.layer insertSublayer:_secondWaveLayer below:_insideWaveLayer];
    
    //    [self drawCurrentWaveWithLayer:_frontWaveLayer offset:offsetF];
    //    [self drawCurrentWaveWithLayer:_insideWaveLayer offset:offsetS];
    
}

-(void)drawCurrentWaveWithLayer:(CAShapeLayer *)waveLayer offset:(CGFloat)offset
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat y = currentK;
    CGPathMoveToPoint(path, nil, 0, y); //将点移动到坐标（0,k）
    
    //以1个像素为单位，[0,视图宽度]为定义域，遍历函数中所有的点，将点连成线
    for (NSInteger i = 0; i <= waveWidth; i++) {
        
        y = waveA * sin(waveW * i + offset) + currentK;
        
        CGPathAddLineToPoint(path, nil, i, y);
    }
    
    CGPathAddLineToPoint(path, nil, waveWidth, waveHeight); //将函数末尾与视图右下角相连
    CGPathAddLineToPoint(path, nil, 0, waveHeight); //连线到视图左下角
    
    CGPathCloseSubpath(path); //将当前点与起点相连并关闭path
    
    waveLayer.path = path; //设置path
    
    CGPathRelease(path);
}


-(void)setFrontColor:(UIColor *)frontColor
{
    if (_frontColor != frontColor) {
        _frontColor = frontColor;
        _frontWaveLayer.fillColor = _frontColor.CGColor;
    }
}

-(void)setInsideColor:(UIColor *)insideColor
{
    if (_insideColor != insideColor) {
        _insideColor = insideColor;
        _insideWaveLayer.fillColor = _insideColor.CGColor;
    }
}

-(void)setFrontSpeed:(CGFloat)frontSpeed
{
    if (_frontSpeed != frontSpeed) {
        _frontSpeed = frontSpeed;
        waveSpeedF = _frontSpeed;
    }
}

-(void)setInsideSpeed:(CGFloat)insideSpeed
{
    if (_insideSpeed != insideSpeed) {
        _insideSpeed = insideSpeed;
        waveSpeedS = _insideSpeed;
    }
}

-(void)setWaveOffset:(CGFloat)waveOffset
{
    if (_waveOffset != waveOffset) {
        _waveOffset = waveOffset;
        offsetS = offsetF + _waveOffset;
    }
}

-(void)setDirectionType:(WaveDirectionType)directionType
{
    if (_directionType != directionType) {
        _directionType = directionType;
        direction = _directionType;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
