//
//  OrderDetail.m
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//


#import "OrderDetail.h"

@implementation OrderDetail

@synthesize peopleName;
@synthesize restaurantName;
@synthesize packagesName;
@synthesize price;

- (id)initWithPeopleName:(NSString *)_peopleName andRestaurantName:(NSString *)_restaurantName andPackagesName:(NSString *)_packagesName andPrice:(id)_price
{
    if (self = [super init]) {
        self.peopleName = _peopleName;
        self.restaurantName = _restaurantName;
        self.packagesName = _packagesName;
        self.price = _price;
    }
    return self;
}


@end