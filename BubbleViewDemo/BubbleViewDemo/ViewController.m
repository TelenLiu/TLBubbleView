//
//  ViewController.m
//  BubbleViewDemo
//
//  Created by Telen on 15/12/6.
//  Copyright © 2015年 刘赞黄Telen. All rights reserved.
//

#import "ViewController.h"
#import "TLBubbleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGPoint pt = self.view.center;
    pt.y -= 200;
    
    CGSize size = self.view.frame.size;
    size.width = 100;
    size.height = 100;
    TLBubbleView* bview = [TLBubbleView TLBubbleViewWithSize:size];
    bview.arrowDirectorType = TLBubbleArrowType_Top;
    bview.arrowLineRatio = 0.33;
    bview.arrowHeight = 10;
    bview.borderWidth = 2;
    bview.borderColor = [UIColor whiteColor];
    bview.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    [bview displayMask];
    bview.pt_Arrow = pt;
    
    NSLog(@"%@ -- %@",NSStringFromCGPoint(self.view.center),NSStringFromCGPoint(bview.pt_Arrow));
    NSLog(@"%@",NSStringFromCGRect(bview.contentView.frame));
    
    [self.view addSubview:bview];
    
    
    size.width = 100;
    size.height = 100;
    bview = [TLBubbleView TLBubbleViewWithSize:size];
    bview.arrowDirectorType = TLBubbleArrowType_Bottom;
    bview.arrowLineRatio = 0.33;
    bview.arrowHeight = 10;
    bview.borderWidth = 2;
    bview.borderColor = [UIColor whiteColor];
    bview.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [bview displayMask];
    bview.pt_Arrow = pt;
    
    NSLog(@"%@ -- %@",NSStringFromCGPoint(self.view.center),NSStringFromCGPoint(bview.pt_Arrow));
    NSLog(@"%@",NSStringFromCGRect(bview.contentView.frame));
    
    [self.view addSubview:bview];
    
    bview.arrowHeight = 6;
    bview.arrowLineRatio = 0.66;
    [bview displayMask];
    
    //
    
    pt.y += 110;
    
    size.width = 420/2;
    size.height = 328/2;
    bview = [TLBubbleView TLBubbleViewWithSize:size];
    bview.arrowDirectorType = TLBubbleArrowType_Top;
    bview.arrowLineRatio = 0.5;
    bview.arrowHeight = 30;
    bview.arrowAngle = M_PI/6;
    bview.borderWidth = 0;
    bview.borderColor = [UIColor yellowColor];
    bview.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    [bview displayMask];
    bview.pt_Arrow = pt;
    
    UIImageView* igv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    igv.image = [UIImage imageNamed:@"cccsee20151206-0.png"];
    [bview addSubview:igv];
    
    
    [self.view addSubview:bview];
    //
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
