//
//  Tomcat.h
//  MsgForwarding
//
//  Created by Enki on 17/4/21.
//  Copyright © 2017年 Maxhub. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PerformanceInterface <NSObject>

@optional
- (void)speak:(NSString *) text;
- (void)dance;
- (void)singing:(NSString *) name;

@end

@interface Tomcat : NSObject <PerformanceInterface>

@end

@interface Chicken : NSObject <PerformanceInterface>

@end

@interface Lion : NSObject <PerformanceInterface>

@end
