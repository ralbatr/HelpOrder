//
//  ReadJson.m
//  HelpOrder
//
//  Created by Ralbatr on 13-9-4.
//  Copyright (c) 2013年 Ralbatr. All rights reserved.
//

#import "ReadJson.h"
#import "SBJson.h"

@implementation ReadJson

- (id)readJosonwithFileName:(NSString *)fileName
{
    NSString *userPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    id jsonString = [NSString stringWithContentsOfFile:userPath encoding:NSUTF8StringEncoding error:NULL];
    
    SBJsonParser * parser = [[SBJsonParser alloc] init];    
    id returnID = [parser objectWithString:jsonString error:nil];
    
    return returnID;
}

- (void)writeJsonWithJsonName:(NSString *)jsonName andValue:(NSString *)string
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath=[paths objectAtIndex:0];
    //取得完整的文件名
    NSString *fileName=[plistPath stringByAppendingPathComponent:jsonName];
    //创建并写入文件 即 清空 文件 内容
    [string writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
