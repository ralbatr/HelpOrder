//
//  SelectPackages.h
//  HelpOrder
//
//  Created by Ralbatr on 13-9-5.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPackages : UIView

- (id)initWithFrame:(CGRect)frame andName:(NSString *)name andPrice:(NSString *)price;
- (void)showSelectPackesViewWithName:(NSString *)name andPrice:(NSString *)price;

@end
