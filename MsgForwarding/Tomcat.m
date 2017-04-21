//
//  Tomcat.m
//  MsgForwarding
//
//  Created by Enki on 17/4/21.
//  Copyright © 2017年 Maxhub. All rights reserved.
//

#import "Tomcat.h"
#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

void dynamicMethod(id self, SEL _cmd, NSString *text) {
    
    NSLog(@"dynamicMethod speak:%@", text);
}

void dynamicClassMethod(id self, SEL _cmd) {
    
}

@implementation Chicken

- (void)dance {
    NSLog(@"chicken dance...");
}

- (void)cry{
    NSLog(@"chicken cry...");
}

@end

@implementation Lion

- (void)singing:(NSString *) name {
    NSLog(@"lion singing...");
}

- (void)hunting {
    NSLog(@"lion hunting...");
}

@end

@interface Tomcat ()

@property (nonatomic, strong) Chicken *chicken;
@property (nonatomic, strong) Lion *lion;

@end

@implementation Tomcat

- (instancetype)init {
    self = [super init];
    if ( nil != self ) {
        _chicken = [[Chicken alloc] init];
        _lion = [[Lion alloc] init];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if ( sel == @selector(speak:) ) {
        
        class_addMethod([self class], sel, (IMP)dynamicMethod, "v@:");
        return YES;
        
    } else {
        
        return [super resolveInstanceMethod:sel];
    }
    
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
        
    if ( aSelector == @selector(dance) && [_chicken respondsToSelector:aSelector] ) {
        
        return _chicken;
        
    } else {
        return [super forwardingTargetForSelector:aSelector];
    }
    
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSMethodSignature *ms = [_lion methodSignatureForSelector:aSelector];
    
    if ( nil == ms ) {
        ms = [_chicken methodSignatureForSelector:aSelector];
    }
    
    return ms;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    SEL sel = [anInvocation selector];
    
    if ( [_lion respondsToSelector:sel] ) {
        
        [anInvocation invokeWithTarget:_lion];
        
    } else if ( [_chicken respondsToSelector:sel] ) {
        
        [anInvocation invokeWithTarget:_chicken];
        
    } else {
        
        [super forwardInvocation:anInvocation];
    }
}

@end
