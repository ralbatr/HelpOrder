//
//  OrderView.m
//  HelpOrder
//
//  Created by Ralbatr on 13-9-4.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "OrderView.h"

@implementation OrderView

- (id)initWithFrame:(CGRect)frame andTarget:(id)Target andPersonSEL:(SEL)PersonMethod andRastauranSEL:(SEL)rastauranMethod andPackagesSEL:(SEL)packagesMethod andAffirmSEL:(SEL)affirmMethod
{
    self = [super initWithFrame:frame];
    if (self) {
        [self ShowOrderViewWithTarget:Target andPersonSEL:PersonMethod andRastauranSEL:rastauranMethod andPackagesSEL:packagesMethod andAffirmSEL:affirmMethod];
        [self showThreeLabel];
        [self showThreeTextField];
    }
    return self;
}

- (void)ShowOrderViewWithTarget:(id)Target andPersonSEL:(SEL)PersonMethod andRastauranSEL:(SEL)rastauranMethod andPackagesSEL:(SEL)packagesMethod andAffirmSEL:(SEL)affirmMethod
{
    [self showButtonWithTarget:Target andSEL:PersonMethod andNumber:0 andButtonName:@"选 人"];
    [self showButtonWithTarget:Target andSEL:rastauranMethod andNumber:1 andButtonName:@"选餐厅"];
    [self showButtonWithTarget:Target andSEL:packagesMethod andNumber:2 andButtonName:@"选套餐"];
    
    UIButton *affirmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    affirmButton.frame = CGRectMake(10, 360, 300, 35);
    [affirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [affirmButton addTarget:Target action:@selector(affirmMethod) forControlEvents:UIControlEventTouchUpInside];
    affirmButton.tag = 105;
    //初始后， 确认 按钮不可用
    [affirmButton setEnabled:NO];
    [self addSubview:affirmButton];
}

- (void)showThreeLabel
{
    NSArray *LabelName = @[@"人：",@"餐厅：",@"套餐："];
    int y = 0;
    for (int i = 0; i < 3; i++) {
        UILabel *Label = [[UILabel alloc] init];
        Label.frame = CGRectMake(10, y, 80, 35);
        y += 120;
        Label.text = [LabelName objectAtIndex:i];
        [self addSubview:Label];
    }
}

- (void)showThreeTextField
{
    int tag = 101;
    int y = 0;
    for (int i = 0; i < 3; i++) {
        UITextField *TextField = [[UITextField alloc] init];
        TextField.frame = CGRectMake(10, 40 + y, 300, 35);
        y += 120;
        TextField.borderStyle = UITextBorderStyleRoundedRect;
        TextField.adjustsFontSizeToFitWidth = YES;
        TextField.tag = tag++;
        TextField.enabled = NO;
        [self addSubview:TextField];
    }
}

- (void)showButtonWithTarget:(id)Target andSEL:(SEL)Method andNumber:(int)Number andButtonName:(NSString *)name;
{
    int y = 120 * Number + 80;
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    Button.frame = CGRectMake(10, y, 300, 35);
    [Button setTitle:name forState:UIControlStateNormal];
    [Button addTarget:Target action:Method forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:Button];
}

@end
