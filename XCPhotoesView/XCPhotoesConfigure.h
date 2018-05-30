//
//  XCPhotoesConfigure.h
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2017/3/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

/*
 *  备注：图片选项配置类 🐾
 */

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, XCPhotoesViewType)
{
    // 展览模式（没有添加图片的按钮，不能删除图片，可点击图片）
    XCPhotoesViewTypeDisPlay = 0,
    
    // 编辑模式（没有添加图片的按钮，可以删除图片，可点击图片）
    XCPhotoesViewTypeEdit
};


@interface XCPhotoesConfigure : NSObject

/** 👀 视图类型：默认 XCPhotoesViewTypeEdit 👀 */
@property (assign, nonatomic) XCPhotoesViewType photoesViewType;

/** 👀 列数：默认 3 👀 */
@property (assign, nonatomic) NSInteger column;

/** 👀 最大显示的图片数量，此时会隐藏添加按钮（编辑模式有用，默认 9 ） 👀 */
@property (assign, nonatomic) NSInteger maxCount;

/** 👀 相邻两个item之间的距离：默认 10 👀 */
@property (assign, nonatomic) CGFloat itemMargin;

/** 👀 视图 上、左、下、右 的距离：默认 15 👀 */
@property (assign, nonatomic) UIEdgeInsets photoesInsets;

/** 👀 添加按钮的图片 👀 */
@property (strong, nonatomic) UIImage *addImage;

/** 👀 删除按钮的图片 👀 */
@property (strong, nonatomic) UIImage *deleteImage;

/** 👀 视图宽度：默认 屏幕宽度 👀 */
@property (assign, nonatomic) CGFloat photoesWidth;

/**
 默认配置
 */
+ (instancetype)defaultConfigure;

@end


