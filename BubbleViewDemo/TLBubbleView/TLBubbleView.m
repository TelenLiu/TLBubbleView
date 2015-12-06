//
//  TLBubbleView.m
//  Sharper
//
//  Created by Telen on 15/12/3.
//  Copyright © 2015年 刘赞黄Telen. All rights reserved.
//

#import "TLBubbleView.h"

typedef struct
{
    CGFloat top,left,bottom,right;
}TLBubblePod;

@implementation TLBubbleView
@synthesize radius;

//CGPathAddArc函数是通过圆心和半径定义一个圆，然后通过两个弧度确定一个弧线。注意弧度是以当前坐标环境的X轴开始的。
// CGPathAddArc(path, &transform, 50, 50, 50, 0, 1.5 * M_PI, NO); //YES 顺时针
/*
 void CGPathAddArc(CGMutablePathRef __nullable path,
 const CGAffineTransform * __nullable m,
 CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle,
 bool clockwise)
 */

- (void)displayMask
{
    //
    CGSize size = self.frame.size;
    TLBubblePod pod = [self pod];
    //
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    //
    //
    CGFloat bw = 0;
    CGFloat ll = 0;
    CGMutablePathRef path = CGPathCreateMutable();
    //右下角
    CGPathMoveToPoint(path, NULL, size.width-pod.right-radius, size.height-pod.bottom);
    CGPathAddArc(path, NULL, size.width-pod.right-radius, size.height-pod.bottom-radius, radius, M_PI*0.5, 0.0, YES);
    //右箭头
    if (pod.right > 0) {
        bw = tan(_arrowAngle) * pod.right;
        ll = size.height - (pod.top+radius) -(pod.bottom+radius) - bw*2;
        if (ll > 0 && _arrowLineRatio >= 0 && _arrowLineRatio <= 1) {
            CGPathAddLineToPoint(path, NULL, size.width-pod.right, pod.top+radius+(ll*_arrowLineRatio)+bw*2);
            CGPathAddLineToPoint(path, NULL, size.width, pod.top+radius+(ll*_arrowLineRatio)+bw);
            CGPathAddLineToPoint(path, NULL, size.width-pod.right, pod.top+radius+(ll*_arrowLineRatio));
        }
    }
    //右上角
    CGPathAddLineToPoint(path, NULL, size.width-pod.right, radius+pod.top);
    CGPathAddArc(path, NULL, size.width-pod.right-radius, radius+pod.top, radius, 0.0, M_PI*1.5, YES);
    //上箭头
    if (pod.top > 0) {
        bw = tan(_arrowAngle) * pod.top;
        ll = size.width - (pod.left+radius) -(pod.right+radius) - bw*2;
        if (ll > 0 && _arrowLineRatio >= 0 && _arrowLineRatio <= 1) {
            CGPathAddLineToPoint(path, NULL, pod.left+radius+(ll*_arrowLineRatio)+bw*2, pod.top);
            CGPathAddLineToPoint(path, NULL, pod.left+radius+(ll*_arrowLineRatio)+bw, 0.0);
            CGPathAddLineToPoint(path, NULL, pod.left+radius+(ll*_arrowLineRatio), pod.top);
        }
    }
    //左上角
    CGPathAddLineToPoint(path, NULL, pod.left+radius, pod.top);
    CGPathAddArc(path, NULL, pod.left+radius, pod.top+radius, radius, M_PI*1.5, M_PI, YES);
    //左箭头
    if (pod.left > 0) {
        bw = tan(_arrowAngle) * pod.left;
        ll = size.height - (pod.top+radius) -(pod.bottom+radius) - bw*2;
        if (ll > 0 && _arrowLineRatio >= 0 && _arrowLineRatio <= 1) {
            CGPathAddLineToPoint(path, NULL, pod.left, pod.top+radius+(ll*_arrowLineRatio));
            CGPathAddLineToPoint(path, NULL, 0.0, pod.top+radius+(ll*_arrowLineRatio)+bw);
            CGPathAddLineToPoint(path, NULL, pod.left, pod.top+radius+(ll*_arrowLineRatio)+bw*2);
        }
    }
    //左下角
    CGPathAddLineToPoint(path, NULL, pod.left, size.height-pod.bottom - radius);
    CGPathAddArc(path, NULL, pod.left+radius, size.height-pod.bottom - radius, radius, M_PI, M_PI*0.5, YES);
    //下箭头
    if (pod.bottom > 0) {
        bw = tan(_arrowAngle) * pod.bottom;
        ll = size.width - (pod.left+radius) -(pod.right+radius) - bw*2;
        if (ll > 0 && _arrowLineRatio >= 0 && _arrowLineRatio <= 1) {
            CGPathAddLineToPoint(path, NULL, pod.left+radius+(ll*_arrowLineRatio), size.height-pod.bottom);
            CGPathAddLineToPoint(path, NULL, pod.left+radius+(ll*_arrowLineRatio)+bw, size.height);
            CGPathAddLineToPoint(path, NULL, pod.left+radius+(ll*_arrowLineRatio)+bw*2, size.height-pod.bottom);
        }
    }
    //闭线
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CGMutablePathRef path_b = CGPathCreateMutableCopy(path);
    CFRelease(path);
    
    self.layer.mask = shapeLayer;//layer的mask，顾名思义，是种位掩蔽，在shapeLayer的填充区域中，alpha值不为零的部分，self会被绘制；alpha值为零的部分，self不会被绘制
    //-----------------
    //
    CAShapeLayer *borderLayer=[CAShapeLayer layer];
    borderLayer.path    =   path_b;
    borderLayer.fillColor  = [UIColor clearColor].CGColor;
    borderLayer.strokeColor    = _borderColor.CGColor;
    borderLayer.lineWidth      = _borderWidth;
    borderLayer.frame=self.bounds;
    borderLayer.zPosition = 10000;
    [self.layer addSublayer:borderLayer];
    //
    [self flashContentFrame];
}

- (void)setPt_Arrow:(CGPoint)pt_Arrow
{
    CGPoint mypt = [self myArrowPT];
    if (CGPointEqualToPoint(mypt, CGPointZero)) {
        return;
    }
    CGPoint center = pt_Arrow;
    CGSize size = self.frame.size;
    center.x += (size.width*0.5 - mypt.x);
    center.y += (size.height*0.5 - mypt.y);
    self.center = center;
}

- (CGPoint)pt_Arrow
{
    CGPoint mypt = [self myArrowPT];
    if (CGPointEqualToPoint(mypt, CGPointZero)) {
        return CGPointZero;
    }
    CGPoint center = self.center;
    CGSize size = self.frame.size;
    center.x -= (size.width*0.5 - mypt.x);
    center.y -= (size.height*0.5 - mypt.y);
    return center;
}

- (CGPoint)myArrowPT
{
    CGFloat bw = 0;
    CGFloat ll = 0;
    CGSize size = self.frame.size;
    TLBubblePod pod = [self pod];
    //
    CGPoint apt = CGPointZero;
    //
    if (pod.top > 0) {
        bw = tan(_arrowAngle) * pod.top;
        ll = size.width - (pod.left+radius) -(pod.right+radius) - bw*2;
        if (ll > 0 && _arrowLineRatio >= 0 && _arrowLineRatio <= 1) {
            apt = CGPointMake(pod.left+radius+(ll*_arrowLineRatio)+bw, 0);
        }
    }
    
    else if (pod.bottom > 0) {
        bw = tan(_arrowAngle) * pod.bottom;
        ll = size.width - (pod.left+radius) -(pod.right+radius) - bw*2;
        if (ll > 0 && _arrowLineRatio >= 0 && _arrowLineRatio <= 1) {
            apt = CGPointMake(pod.left+radius+(ll*_arrowLineRatio)+bw, size.height);
        }
    }
    
    else if (pod.left > 0) {
        bw = tan(_arrowAngle) * pod.left;
        ll = size.height - (pod.top+radius) -(pod.bottom+radius) - bw*2;
        if (ll > 0 && _arrowLineRatio >= 0 && _arrowLineRatio <= 1) {
            apt = CGPointMake(0, pod.top+radius+(ll*_arrowLineRatio)+bw);
        }
    }
    
    else if (pod.right > 0) {
        bw = tan(_arrowAngle) * pod.right;
        ll = size.height - (pod.top+radius) -(pod.bottom+radius) - bw*2;
        if (ll > 0 && _arrowLineRatio >= 0 && _arrowLineRatio <= 1) {
            apt = CGPointMake(size.width, pod.top+radius+(ll*_arrowLineRatio)+bw);
        }
    }
    
    return apt;
}

- (TLBubblePod)pod
{
    TLBubblePod pod;
    pod.bottom = pod.top = pod.left = pod.right = 0;
    switch (_arrowDirectorType) {
        case TLBubbleArrowType_Top:
            pod.top = _arrowHeight;
            break;
        case TLBubbleArrowType_Bottom:
            pod.bottom = _arrowHeight;
            break;
        case TLBubbleArrowType_Left:
            pod.left = _arrowHeight;
            break;
        case TLBubbleArrowType_Right:
            pod.right = _arrowHeight;
            break;
        default:
            break;
    }
    
    return pod;
}

- (void)flashContentFrame
{
    TLBubblePod pod = [self pod];
    CGRect frame = self.frame;
    frame.origin.x = pod.left;
    frame.origin.y = pod.top;
    frame.size.width -= pod.left + pod.right;
    frame.size.height -= pod.top + pod.bottom;
    _contentView.frame = frame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
    }
    return self;
}

+ (instancetype)TLBubbleViewWithSize:(CGSize)size
{
    TLBubbleView* bbview = [[self alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    bbview.arrowDirectorType = TLBubbleArrowType_None;
    bbview.arrowAngle = M_PI_4;
    bbview.arrowLineRatio = 0.5;
    bbview.arrowHeight = 16;
    bbview.radius = 12;
    bbview.borderColor = [UIColor clearColor];
    bbview.borderWidth = 0;
    return bbview;
}

@end
