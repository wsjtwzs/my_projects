//
//  HTTPClient.h
//  moshTickets
//
//  Created by 魔时网 on 13-11-14.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPClient : NSObject

/*
 单例
 */
+ (HTTPClient *) shareHTTPClient;

@end