//
//  RootViewController.h
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderViewController.h"

@interface RootViewController : UIViewController <OrderViewControllerDelegate>
{
    NSMutableArray *orderArray;
}

@property (nonatomic,retain) NSMutableArray *orderArray;

@end
