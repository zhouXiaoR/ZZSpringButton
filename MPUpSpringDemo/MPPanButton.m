//
//  MPPanButton.m
//  MPUpSpringDemo
//
//  Created by 周晓瑞 on 2017/3/29.
//  Copyright © 2017年 colleny. All rights reserved.
//

#import "MPPanButton.h"

#define FAR_LAST_DISTANCE  200

@interface MPPanButton ()
@property(nonatomic,weak)UIView *smallCircleView;
@property(nonatomic,weak)CAShapeLayer *shapeLayer;
@end

@implementation MPPanButton

#pragma mark - 设置边框宽度
- (void)setBorderZXWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) return;
    
    self.layer.borderWidth = borderWidth;
}

#pragma mark - 设置边框颜色
- (void)setBorderColor:(UIColor *)borderColor {
    
    self.layer.borderColor = borderColor.CGColor;
}

#pragma mark - 设置圆角
- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (CAShapeLayer *)shapeLayer{
    if (_shapeLayer==nil) {
        CAShapeLayer *shapeL = [CAShapeLayer layer];
        shapeL.fillColor = [UIColor redColor].CGColor;
        [self.superview.layer addSublayer:shapeL];
        _shapeLayer = shapeL;
    }
    return _shapeLayer;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
    [self addPanGs];
}

- (void)setUp{
    UIView *smallView = [[UIView alloc]init];
    smallView.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    smallView.center = self.center;
    smallView.backgroundColor=[UIColor orangeColor];
    smallView.layer.cornerRadius = self.bounds.size.width/2.0;
    [self.superview addSubview:smallView];
    [self.superview insertSubview:smallView belowSubview:self];
    self.smallCircleView = smallView;
}
- (void)addPanGs{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer*)pan{
    
    CGPoint transP = [pan translationInView:self];
 /*竟然frame发生变化，中心点center却不变   self.transform= CGAffineTransformTranslate(self.transform, transP.x, transP.y);*/
    
    CGPoint point = self.center;
    point.x += transP.x;
    point.y+= transP.y;
    self.center = point;
    [pan setTranslation:CGPointZero inView:self];
    CGFloat temDis =
    [self distanceWithSmallCircleView:self.smallCircleView bigCircleView:self];
    
    CGFloat widthValue = self.bounds.size.width - temDis/6.0;
    self.smallCircleView.bounds = CGRectMake(0, 0, widthValue, widthValue);
    self.smallCircleView.layer.cornerRadius = widthValue/2.0;
    
    if(self.smallCircleView.hidden == NO){
        self.shapeLayer.path = [self bezierPathWithSmallView:self.smallCircleView bigCircleView:self].CGPath;
    }
    
    if (temDis>FAR_LAST_DISTANCE) {
        self.smallCircleView.hidden = YES;
        [self.shapeLayer removeFromSuperlayer];
        //播放爆炸动画
    }

    if (pan.state == UIGestureRecognizerStateEnded) {
        if (temDis<FAR_LAST_DISTANCE) {
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.center = self.smallCircleView.center;
                [self.shapeLayer removeFromSuperlayer];
            } completion:^(BOOL finished) {
                self.smallCircleView.hidden = NO;
            }];
        }else{
            //消失动画爆炸
        }
    }
}

- (CGFloat)distanceWithSmallCircleView:(UIView*)smv bigCircleView:(UIView*)bgV{
    
    CGFloat smallCenterX = smv.center.x;
    CGFloat smallCenterY = smv.center.y;
    CGFloat bgCenterX = bgV.center.x;
    CGFloat bgCenterY = bgV.center.y;
    
    CGFloat xv = bgCenterX - smallCenterX;
    CGFloat yv = bgCenterY - smallCenterY;
    CGFloat  distance = sqrt(xv*xv + yv*yv);
    
    distance = MAX(0, distance);
    
    return distance;
}

- (UIBezierPath*)bezierPathWithSmallView:(UIView*)smv bigCircleView:(UIView*)bgV{
  
    CGFloat smallCenterX = smv.center.x;
    CGFloat smallCenterY = smv.center.y;
    
    CGFloat bgCenterX= bgV.center.x;
    CGFloat bgCenterY= bgV.center.y;
    
    CGFloat  distance = [self distanceWithSmallCircleView:smv bigCircleView:bgV];
    if(distance<=0)return nil;
    
    CGFloat sA = (bgCenterX - smallCenterX)/distance ;
    CGFloat cA = (bgCenterY - smallCenterY)/distance;

    CGFloat smaRadius = smv.bounds.size.width / 2.0;
    CGFloat bgRadius = bgV.bounds.size.width / 2.0;
    
    CGPoint pointA = CGPointMake(smallCenterX-smaRadius*cA, smallCenterY+smaRadius*sA);
    CGPoint pointB = CGPointMake(smallCenterX+smaRadius*cA, smallCenterY-smaRadius*sA);
    CGPoint pointC = CGPointMake(bgCenterX+bgRadius*cA, bgCenterY-bgRadius*sA);
    CGPoint pointD =CGPointMake(bgCenterX-bgRadius*cA, bgCenterY+bgRadius*sA);
    
    CGPoint pointO = CGPointMake(pointA.x + distance*0.5*sA , pointA.y+distance*0.5*cA);
    CGPoint pointP = CGPointMake(pointB.x+distance*0.5*sA, pointB.y + distance*0.5*cA);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    [path addLineToPoint:pointD];
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    return path;
}

@end
