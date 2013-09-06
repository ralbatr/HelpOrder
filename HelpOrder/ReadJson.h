//
//  ReadJson.h
//  HelpOrder
//
//  Created by Ralbatr on 13-9-4.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadJson : NSObject

- (id)readJosonwithFileName:(NSString *)fileName;

- (void)writeJsonWithJsonName:(NSString *)jsonName andValue:(NSString *)string;

@end
