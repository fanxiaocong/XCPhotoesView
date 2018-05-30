//
//  XCPhotoesConfigure.m
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2017/3/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：图片选项配置类 🐾
 */

#import "XCPhotoesConfigure.h"

@implementation XCPhotoesConfigure

/**
 默认配置
 */
+ (instancetype)defaultConfigure
{
    XCPhotoesConfigure *configure = [[XCPhotoesConfigure alloc] init];
    
    configure.photoesViewType = XCPhotoesViewTypeEdit;
    configure.column          = 3;
    configure.maxCount        = 9;
    configure.itemMargin      = 10;
    configure.photoesInsets   = UIEdgeInsetsMake(15, 15, 15, 15);
    configure.photoesWidth    = [UIScreen mainScreen].bounds.size.width;
    
    return configure;
}

@end
