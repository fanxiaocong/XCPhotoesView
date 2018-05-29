//
//  XCPhotoItem.m
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2017/3/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//


/*
 *  备注：图片单元 🐾
 */


#import "XCPhotoItem.h"


@interface XCPhotoItem ()

/** 👀 删除按钮 👀 */
@property (weak, nonatomic) UIButton *deleteButton;

@end


@implementation XCPhotoItem

#pragma mark - 👀 Init Method 👀 💤

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 设置默认参数
        [self setupDefaults];
    }
    
    return self;
}

/**
 *  设置默认参数
 */
- (void)setupDefaults
{
    self.userInteractionEnabled = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    // 设置删除按钮
    [self setUpDeleteButton];
}

/**
 *  设置删除按钮
 */
- (void)setUpDeleteButton
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addTarget:self action:@selector(didClickDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    self.deleteButton = button;
}

- (void)setDeleteImage:(UIImage *)deleteImage
{
    _deleteImage = deleteImage;
    
    [self.deleteButton setImage:deleteImage forState:UIControlStateNormal];
}

- (void)setEdit:(BOOL)edit
{
    _edit = edit;
    
    self.deleteButton.hidden = !self.canEdit;
}

/**
 *  设置尺寸
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置 删除按钮 的 frame
    UIButton *button = self.subviews.lastObject;
    
    CGFloat margin   = 5;
    CGFloat buttonWH = 20;
    CGFloat buttonX  = self.bounds.size.width - buttonWH - margin;
    CGFloat buttonY  = margin;
    
    button.frame = CGRectMake(buttonX, buttonY, buttonWH, buttonWH);
}


#pragma mark - 🎬 👀 Action Method 👀

/**
 *  点击了删除按钮
 */
- (void)didClickDeleteButton
{
    if (self.didClickDeleteButtonHandle)
    {
        self.didClickDeleteButtonHandle(self);
    }
}

/**
 *  点击了 item 本身
 */
- (void)didClick
{
    if (self.didClickItemHandle)
    {
        self.didClickItemHandle(self);
    }
}


@end





