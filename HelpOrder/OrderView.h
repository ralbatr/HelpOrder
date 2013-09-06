//
//  OrderView.h
//  HelpOrder
//
//  Created by Ralbatr on 13-9-4.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderView : UIView

- (id)initWithFrame:(CGRect)frame andTarget:(id)Target andPersonSEL:(SEL)PersonMethod andRastauranSEL:(SEL)rastauranMethod andPackagesSEL:(SEL)packagesMethod andAffirmSEL:(SEL)affirmMethod;

- (void)ShowOrderViewWithTarget:(id)Target andPersonSEL:(SEL)PersonMethod andRastauranSEL:(SEL)rastauranMethod andPackagesSEL:(SEL)packagesMethod andAffirmSEL:(SEL)affirmMethod;

- (void)showThreeLabel;

- (void)showButtonWithTarget:(id)Target andSEL:(SEL)Method andNumber:(int)Number andButtonName:(NSString *)name;

@end
