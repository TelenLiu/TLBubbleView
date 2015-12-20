//
//  TLBubbleView.h
//  Sharper
//
//  Created by Telen on 15/12/3.
//  Copyright © 2015年 刘赞黄Telen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TLBubbleArrowType_None,
    TLBubbleArrowType_Top,
    TLBubbleArrowType_Left,
    TLBubbleArrowType_Bottom,
    TLBubbleArrowType_Right,
} TLBubbleArrowDirectorType;

@interface TLBubbleView : UIView
@property(nonatomic,strong,readonly)UIView* contentView; //displayMask后自动更新Frame 矩形区域
@property(nonatomic,assign)TLBubbleArrowDirectorType arrowDirectorType; //箭头方向
@property(nonatomic,assign)CGFloat arrowLineRatio;//箭头所在的偏离率（0-1）
@property(nonatomic,assign)CGFloat arrowHeight;//箭头的高度
@property(nonatomic,assign)CGFloat arrowAngle;//箭头角度
@property(nonatomic,assign)CGFloat radius;//圆角大小
@property(nonatomic,assign)CGFloat borderWidth;//线宽
@property(nonatomic,strong)UIColor* borderColor;//颜色
@property(nonatomic,assign)CGPoint pt_Arrow; //箭头的顶点位置 与 ceneter自动换算

//获得实例
+ (instancetype)TLBubbleViewWithSize:(CGSize)size;

//设置属性 完后，执行此方法，塑造气泡蒙版
- (void)displayMask;

@end
