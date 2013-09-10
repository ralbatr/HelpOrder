//
//  RootView.h
//  HelpOrder
//
//  Created by Ralbatr on 13-9-4.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootView : UIView

-(id)initWithButtonTarget:(id)aTarget andSEL:(SEL)aSEL andOtherTarget:(id)otherTarget andOtherSEL:(SEL)otherSEL withFrame:(CGRect)frame;

@end
