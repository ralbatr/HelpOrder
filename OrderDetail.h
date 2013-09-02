//
//  OrderDetail.h
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetail : NSObject
{
    NSString *peopleName;
    NSString *restaurantName;
    NSString *packagesName;
    id  price;
}

@property (nonatomic,copy) NSString *peopleName;
@property (nonatomic,copy) NSString *restaurantName;
@property (nonatomic,copy) NSString *packagesName;
@property (nonatomic,copy) id  price;

- (id)initWithPeopleName:(NSString *)peopleName andRestaurantName:(NSString *)restaurantName andPackagesName:(NSString *)packagesName andPrice:(id)price;

@end
