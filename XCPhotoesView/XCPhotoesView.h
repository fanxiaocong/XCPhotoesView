//
//  XCPhotoesView.h
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2017/3/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：图片显示视图 🐾
 */


#import <UIKit/UIKit.h>

#import "XCPhotoesConfigure.h"


@interface XCPhotoesView : UIView


/** 👀 获取内容的高度 👀 */
@property (copy, nonatomic) void(^fetchContentHeightBlock)(XCPhotoesView *photoesView, CGFloat contentH);


/**
 *  返回一个图片集合视图
 *
 *  @param images                      视图image对象数组
 *  @param configure                   视图参数配置选项（传空为默认配置）
 *  @param didClickAddButtonHandle     点击了添加按钮（编辑模式）
 *  @param didClickDeleteButtonHandle  点击了删除按钮（编辑模式）
 *  @param didSelectItemHandle         点击了某张图片的回调
 */
+ (instancetype)photoesViewWithImages:(NSMutableArray<UIImage *> *)images
                            configure:(XCPhotoesConfigure *)configure
                 didClickAddButtonHnadle:(void(^)(XCPhotoesView *photoesView))didClickAddButtonHandle
              didClickDeleteButtonHandle:(void(^)(XCPhotoesView *photoesView, NSInteger index))didClickDeleteButtonHandle
                     didSelectItemHandle:(void(^)(XCPhotoesView *photoesView, NSInteger index))didSelectItemHandle;

/**
 *  返回一个图片集合视图
 *
 *  @param URLs                        视图image对象数组
 *  @param configure                   视图参数配置选项（传空为默认配置）
 *  @param didClickAddButtonHandle     点击了添加按钮（编辑模式）
 *  @param didClickDeleteButtonHandle  点击了删除按钮（编辑模式）
 *  @param didSelectItemHandle         点击了某张图片的回调
 */
+ (instancetype)photoesViewWithURLs:(NSArray<NSString *> *)URLs
                          configure:(XCPhotoesConfigure *)configure
            didClickAddButtonHnadle:(void(^)(XCPhotoesView *photoesView))didClickAddButtonHandle
         didClickDeleteButtonHandle:(void(^)(XCPhotoesView *photoesView, NSInteger index))didClickDeleteButtonHandle
                didSelectItemHandle:(void(^)(XCPhotoesView *photoesView, NSInteger index))didSelectItemHandle;

/**
 *  添加图片
 */
- (void)addPhotoesWithImages:(NSArray<UIImage *> *)images;

/**
 *  添加图片
 */
- (void)addPhotoesWithUrls:(NSArray<NSString *> *)urls;

/**
 *  加载网络图片
 */
- (void)configureWebImage:(void(^)(UIImageView *imageView, NSURL *URL))webImgconfig;

@end


