//
//  XCPhotoItem.h
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2017/3/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：图片单元 🐾
 */


#import <UIKit/UIKit.h>

@interface XCPhotoItem : UIImageView

/** 👀 是否可编辑（如果可编辑：则右上角有删除按钮；如果不可编辑：则右上角没有删除按钮） 👀 */
@property (assign, nonatomic, getter=canEdit) BOOL edit;

/** 👀 点击了 item 左上角的删除按钮的回调 👀 */
@property (copy, nonatomic) void(^didClickDeleteButtonHandle)(XCPhotoItem *item);

/** 👀 点击了 item 本身的回调 👀 */
@property (copy, nonatomic) void(^didClickItemHandle)(XCPhotoItem *item);

@end
