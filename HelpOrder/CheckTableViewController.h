//
//  CheckTableViewController.h
//  HelpOrder
//
//  Created by Ralbatr on 13-8-31.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "OrderViewController.h"

@interface CheckTableViewController : UITableViewController

{
    NSMutableArray *orderMutableArray;
    NSArray *sectionArray;
    NSMutableArray *peopleNoOrderArray;
}

@property (nonatomic,retain) NSMutableArray *orderMutableArray;
@property (nonatomic,retain) NSMutableArray *peopleNoOrderArray;
@property (nonatomic,retain) NSArray *sectionArray;

@end
