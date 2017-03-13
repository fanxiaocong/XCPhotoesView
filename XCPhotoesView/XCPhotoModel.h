//
//  XCPhotoItem.h
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2017/3/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：每张图片的数据模型 🐾
 */


#import <UIKit/UIKit.h>

@interface XCPhotoModel : NSObject

/** 👀 图片地址 👀 */
@property (copy, nonatomic) NSString *photoUrl;

/** 👀 图片image 👀 */
@property (strong, nonatomic) UIImage *photoImage;

#pragma mark - 👀 Instance Method 👀 💤

- (instancetype)initWithPhotoUrl:(NSString *)photoUrl
                      photoImage:(UIImage *)photoImage;

- (instancetype)initWithPhotoUrl:(NSString *)photoUrl;

- (instancetype)initWithPhotoImage:(UIImage *)photoImage;

#pragma mark - 👀 Class Method 👀 💤

+ (instancetype)photoModelWithUrl:(NSString *)photoUrl
                          photoImage:(UIImage *)photoImage;

+ (instancetype)photoModelWithUrl:(NSString *)photoUrl;

+ (instancetype)photoModelWithPhotoImage:(UIImage *)photoImage;

@end
