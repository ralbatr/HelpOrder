//
//  SelectPackages.m
//  HelpOrder
//
//  Created by Ralbatr on 13-9-5.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "SelectPackages.h"

@implementation SelectPackages

- (id)initWithFrame:(CGRect)frame andName:(NSString *)name andPrice:(NSString *)price
{
    self = [super initWithFrame:frame];
    if (self) {
        [self showSelectPackesViewWithName:name andPrice:price];
    }
    return self;
}

- (void)showSelectPackesViewWithName:(NSString *)name andPrice:(NSString *)price
{
    CGRect nameLabelRect = CGRectMake(0, 8, 200, 25);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
    nameLabel.text = name;
    nameLabel.font = [UIFont boldSystemFontOfSize:20];
    [self addSubview:nameLabel];
    
    CGRect priceLabelRect = CGRectMake(230, 5, 70, 15);
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:priceLabelRect];
    NSString *priceString = [NSString stringWithFormat:@"¥ %@",price];
    priceLabel.text = priceString;
    priceLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:priceLabel];
}

@end
