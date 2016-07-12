//
//  WPTranslucid.m
//  WPTranslucid
//
//  Created by wupeng on 16/7/12.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "WPTranslucid.h"

@interface WPTranslucid ()


@property (nonatomic,strong) CATextLayer *textLayer;
@property (nonatomic,strong) CALayer *imageLayer;
@property (nonatomic,strong) UIFont *textfont;
@end


@implementation WPTranslucid

-(void)setBgImage:(UIImage *)bgImage {
    _bgImage = bgImage;
    self.imageLayer.contents = (__bridge id _Nullable)(bgImage.CGImage);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self contentInit];
        [self loadContent];
        [self autoResizeTextLayer];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self contentInit];
        [self loadContent];
        [self autoResizeTextLayer];
    }
    return self;
}

-(void)awakeFromNib {
    [self loadContent];
    [self autoResizeTextLayer];
}
-(void)contentInit {
    self.fontSize = 30;
    self.text = @"Hello！World!";
    self.bgImage = [UIImage imageNamed:@"bgimage"];
}
-(void)loadContent {
    self.backgroundColor = [UIColor blackColor];
    self.textLayer = [CATextLayer layer];
    self.imageLayer = [CALayer layer];
    
    self.imageLayer.contents = (__bridge id _Nullable)(self.bgImage.CGImage);
    self.textfont = [UIFont fontWithName:@"Starjedi" size:self.fontSize];
    self.textLayer.string = self.text;
    self.textLayer.alignmentMode = kCAAlignmentCenter;
    self.textLayer.wrapped = true;
    self.textLayer.font = (__bridge CFTypeRef _Nullable)(self.textfont);
    self.textLayer.rasterizationScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:self.imageLayer];
    self.layer.mask = self.textLayer;
}
-(void)layoutSubviews {
    [self autoResizeTextLayer];
}
-(void)autoResizeTextLayer {
    [self layoutIfNeeded];
    self.textLayer.frame = self.bounds;
    self.imageLayer.frame = self.bounds;
    [self animate];
}
-(void)animate {
    [self.imageLayer removeAnimationForKey:@"transform"];
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"position"];
    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animate.fromValue = [NSValue valueWithCGPoint:self.imageLayer.position];
    animate.toValue = [NSValue valueWithCGPoint:CGPointMake(self.imageLayer.position.x, self.imageLayer.position.y - self.imageLayer.bounds.size.height)];
    animate.duration = 15.0;
    animate.autoreverses = true;
    animate.repeatCount = INFINITY;
    [self.imageLayer addAnimation:animate forKey:@"transform"];
}

@end
