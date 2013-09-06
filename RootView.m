//
//  RootView.m
//  HelpOrder
//
//  Created by Ralbatr on 13-9-4.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "RootView.h"

@implementation RootView

-(id)initWithButtonTarget:(id)aTarget andSEL:(SEL)aSEL andOtherTarget:(id)otherTarget andOtherSEL:(SEL)otherSEL withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self ShowButtonWithTarget:aTarget andSEL:aSEL andOtherTarget:otherTarget andOtherSEL:otherSEL ];
    }
    return self;
}



- (void)ShowButtonWithTarget:(id)aTarget andSEL:(SEL)aSEL andOtherTarget:(id)otherTarget andOtherSEL:(SEL)otherSEL 
{
    // 帮订餐 按钮
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    orderButton.frame = CGRectMake(20, 40, 280, 40);
    [orderButton setTitle:@"帮订餐" forState:UIControlStateNormal];
    [orderButton addTarget:aTarget action:aSEL forControlEvents:UIControlEventTouchUpInside];
    orderButton.tag = 202;
    [self addSubview:orderButton];
    // 看清单 按钮
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    checkButton.frame = CGRectMake(20, 100, 280, 40);
    [checkButton setTitle:@"看订单" forState:UIControlStateNormal];
    [checkButton addTarget:otherTarget action:otherSEL forControlEvents:UIControlEventTouchUpInside];
    checkButton.tag = 201;
    //初始时，不可以使用查“看订单”按钮
    [checkButton setEnabled:NO];
    [self addSubview:checkButton];
}

@end
