//
//  XCPhotoItem.m
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2017/3/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//



/*
 *  备注：每张图片的数据模型 🐾
 */


#import "XCPhotoModel.h"

@implementation XCPhotoModel

#pragma mark - 👀 Instance Method 👀 💤

- (instancetype)initWithPhotoUrl:(NSString *)photoUrl
                      photoImage:(UIImage *)photoImage
{
    return [XCPhotoModel photoModelWithUrl:photoUrl photoImage:photoImage];
}

- (instancetype)initWithPhotoUrl:(NSString *)photoUrl
{
    return [XCPhotoModel photoModelWithUrl:photoUrl];
}

- (instancetype)initWithPhotoImage:(UIImage *)photoImage
{
    return [XCPhotoModel photoModelWithPhotoImage:photoImage];
}


#pragma mark - 👀 Class Method 👀 💤

+ (instancetype)photoModelWithUrl:(NSString *)photoUrl
                          photoImage:(UIImage *)photoImage
{
    XCPhotoModel *model = [[self alloc] init];
    
    model.photoUrl   = photoUrl;
    model.photoImage = photoImage;
    
    return model;
}

+ (instancetype)photoModelWithUrl:(NSString *)photoUrl
{
    return [XCPhotoModel photoModelWithUrl:photoUrl photoImage:NULL];
}

+ (instancetype)photoModelWithPhotoImage:(UIImage *)photoImage
{
    return [XCPhotoModel photoModelWithUrl:NULL photoImage:photoImage];
}

@end
















