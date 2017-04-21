//
//  ViewController.m
//  MsgForwarding
//
//  Created by Enki on 17/4/20.
//  Copyright © 2017年 Maxhub. All rights reserved.
//

#import "ViewController.h"
#import "Tomcat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // Tomcat 类并未实现任何方法
    id<PerformanceInterface> performance = [[Tomcat alloc] init];
    
    // 动态方法解析
    [performance speak:@"哈哈哈"];
    
    // 消息转发
    [performance dance];
    [performance singing:@"摇滚"];
    
    // 类似 “多重继承” 让 Tomcat 拥有 chicken 和 lion 的所有方法
    [performance performSelector:@selector(hunting)];
    [performance performSelector:@selector(cry)];
    
    // 动态创建的方法 不需要重写
    if ([performance respondsToSelector:@selector(speak:)]) {
        NSLog(@"speak respondsToSelector OK");
    } else {
        NSLog(@"speak respondsToSelector NO");
    }
    
    // 消息转发的 需要重写 respondsToSelector
    if ([performance respondsToSelector:@selector(dance:)]) {
        NSLog(@"dance respondsToSelector OK");
    } else {
        NSLog(@"dance respondsToSelector NO");
    }

}

@end
