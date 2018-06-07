//
//  XCPhotoesView.m
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2017/3/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//



/*
 *  备注：图片显示视图 🐾
 */



#import "XCPhotoesView.h"

#import "XCPhotoItem.h"
#import "XCPhotoModel.h"

#import "UIView+XCPhotoesView.h"


@interface XCPhotoesView ()

/** 👀 添加按钮 👀 */
@property (weak, nonatomic) UIButton *addButton;

/** 👀 配置 👀 */
@property (strong, nonatomic) XCPhotoesConfigure *configure;

/** 👀 模型数组 👀 */
@property (strong, nonatomic) NSMutableArray<XCPhotoModel *> *models;

/** 👀 点击了添加按钮 👀 */
@property (copy, nonatomic) void(^didClickAddButtonHnadle)(XCPhotoesView *photoesView);

/** 👀 点击了删除按钮 👀 */
@property (copy, nonatomic) void(^didClickDeleteButtonHandle)(XCPhotoesView *photoesView, NSInteger index);

/** 👀 点击了某张图片的回调 👀 */
@property (copy, nonatomic) void(^didSelectItemHandle)(XCPhotoesView *photoesView, NSInteger index);

/** 👀 记录视图的尺寸 👀 */
@property (assign, nonatomic) CGFloat photoWH;

@end


@implementation XCPhotoesView
{
    NSArray *_items;
}

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

// 设置默认参数
- (void)setupDefaults
{
    self.userInteractionEnabled = YES;
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton addTarget:self action:@selector(onClickedAddButton) forControlEvents:UIControlEventTouchUpInside];
    self.addButton = addButton;
    [self addSubview:addButton];
}

/**
 *  设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    
    NSInteger column   = self.configure.column;       // 列数
    CGFloat marginX    = self.configure.itemMargin;   // 图片间的间距
    CGFloat leftMargin = self.configure.photoesInsets.left;
    CGFloat topMargin  = self.configure.photoesInsets.top;
    
    CGFloat itemWH = self.photoWH;
    
    for (int i = 0; i<count; i++)
    {
        CGFloat itemX = (i % column) * (itemWH + marginX) + leftMargin;
        CGFloat itemY = (i / column) * (itemWH + marginX) + topMargin;
        
        UIView *view;
        
        if (i < count-1)    // 图片视图
        {
            view = self.subviews[i];
        }
        
        if (i == count-1)   // 添加的按钮
        {
            view = self.addButton;
        }
        
        view.frame = CGRectMake(itemX, itemY, itemWH, itemWH);
    }
    
    switch (self.configure.photoesViewType)
    {
        case XCPhotoesViewTypeDisPlay:
        {
            self.addButton.hidden = YES;
            break;
        }
        case XCPhotoesViewTypeEdit:
        {
            if (self.subviews.count > self.configure.maxCount)
            {
                self.addButton.hidden = YES;
            }
            else
            {
                self.addButton.hidden = NO;
            }
            break;
        }
    }
    
    CGFloat photoesH = self.addButton.bottom + self.configure.photoesInsets.bottom;
    
    if (self.subviews.count > self.configure.maxCount   &&
        (count % column) == 1)
    {
        photoesH -= (itemWH + marginX);
    }
    
    self.height = photoesH;
    
    /// 返回 内容的高度
    if (self.fetchContentHeightBlock)
    {
        self.fetchContentHeightBlock(self, self.height);
    }
}

#pragma mark - 👀 Setter Method 👀 💤

- (void)setModels:(NSMutableArray<XCPhotoModel *> *)models
{
    _models = models;
    
    __weak typeof(self)weakSelf = self;
    
    for (UIView *subView in self.subviews)
    {
        if ([subView isKindOfClass:[UIImageView class]])
        {
            [subView removeFromSuperview];
        }
    }
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    for (XCPhotoModel *model in models)
    {
        XCPhotoItem *item = [[XCPhotoItem alloc] init];
        
        [mArr addObject:item];
        
        item.deleteImage = self.configure.deleteImage;
        
        if (model.photoImage)       // 如果存在 image
        {
            item.image = model.photoImage;
        }
        
        // 添加图片
        [weakSelf insertSubview:item belowSubview:weakSelf.addButton];
        
        switch (self.configure.photoesViewType)
        {
            case XCPhotoesViewTypeDisPlay:      // 不可编辑模式
            {
                self.addButton.hidden = YES;
                item.edit = NO;
                
                break;
            }
            case XCPhotoesViewTypeEdit:        // 可编辑模式
            {
                self.addButton.hidden = NO;
                item.edit = YES;
                
                // 点击了删除按钮
                item.didClickDeleteButtonHandle = ^(XCPhotoItem *item){
                    
                    // 删除 item
                    [weakSelf deleteItem:item model:model];
                };
                
                break;
            }
        }
        
        // 记录 item
        _items = mArr;
        
        // 点击了 item 本身
        item.didClickItemHandle = ^(XCPhotoItem *item){
            
            if (weakSelf.didSelectItemHandle)
            {
                NSInteger index = [weakSelf.models indexOfObject:model];
                
                weakSelf.didSelectItemHandle(weakSelf, index);
            }
        };
    }
}


#pragma mark - 🔓 👀 Public Method 👀

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
                  didSelectItemHandle:(void(^)(XCPhotoesView *photoesView, NSInteger index))didSelectItemHandle
{
    NSMutableArray *models = [NSMutableArray array];
    
    [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx < configure.maxCount) {
            XCPhotoModel *model = [XCPhotoModel photoModelWithPhotoImage:obj];
            [models addObject:model];
        }
    }];
    
    return [self photoesViewWithModels:models
                             configure:configure
               didClickAddButtonHnadle:didClickAddButtonHandle
            didClickDeleteButtonHandle:didClickDeleteButtonHandle
                   didSelectItemHandle:didSelectItemHandle];
}

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
                didSelectItemHandle:(void(^)(XCPhotoesView *photoesView, NSInteger index))didSelectItemHandle
{
    NSMutableArray *models = [NSMutableArray array];
    
    [URLs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx < configure.maxCount) {
            XCPhotoModel *model = [XCPhotoModel photoModelWithUrl:obj];
            [models addObject:model];
        }
    }];
    
    return [self photoesViewWithModels:models
                             configure:configure
               didClickAddButtonHnadle:didClickAddButtonHandle
            didClickDeleteButtonHandle:didClickDeleteButtonHandle
                   didSelectItemHandle:didSelectItemHandle];
}

/**
 *  添加图片
 */
- (void)addPhotoesWithImages:(NSArray<UIImage *> *)images
{
    NSMutableArray *models = [NSMutableArray arrayWithArray:self.models];
    
    [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        XCPhotoModel *model = [XCPhotoModel photoModelWithPhotoImage:obj];
        [models addObject:model];
    }];
    
    self.models = models;
}

/**
 *  添加图上
 */
- (void)addPhotoesWithUrls:(NSArray<NSString *> *)urls
{
    NSMutableArray *models = [NSMutableArray arrayWithArray:self.models];
    
    [urls enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        XCPhotoModel *model = [XCPhotoModel photoModelWithUrl:obj];
        [models addObject:model];
    }];
    
    self.models = models;
}

- (void)configureWebImage:(void(^)(UIImageView *imageView, NSURL *URL))webImgconfig
{
    /// 加载网页图片
    for (NSInteger i = 0; i < _items.count; i ++)
    {
        XCPhotoItem *item = _items[i];
        XCPhotoModel *model = self.models[i];
        
        if (!model.photoUrl)    continue;
        
        if (webImgconfig) {
            webImgconfig(item, [NSURL URLWithString:model.photoUrl]);
        }
    }
}

#pragma mark - 🔒 👀 Privite Method 👀

/**
 *  返回一个图片集合视图
 *
 *  @param models                      视图模型数组
 *  @param configure                   视图配置参数
 *  @param didClickAddButtonHandle     点击了添加按钮（编辑模式）
 *  @param didClickDeleteButtonHandle  点击了删除按钮（编辑模式）
 *  @param didSelectItemHandle         点击了某张图片的回调
 */
+ (instancetype)photoesViewWithModels:(NSMutableArray<XCPhotoModel *> *)models
                            configure:(XCPhotoesConfigure *)configure
              didClickAddButtonHnadle:(void(^)(XCPhotoesView *photoesView))didClickAddButtonHandle
           didClickDeleteButtonHandle:(void(^)(XCPhotoesView *photoesView, NSInteger index))didClickDeleteButtonHandle
                  didSelectItemHandle:(void(^)(XCPhotoesView *photoesView, NSInteger index))didSelectItemHandle
{
    configure = configure ?: [XCPhotoesConfigure defaultConfigure];
    
    // 计算每张图片的宽、高
    CGFloat itemWH = (configure.photoesWidth - configure.photoesInsets.left - configure.photoesInsets.right - (configure.column - 1) * configure.itemMargin) / configure.column;
    
    // 计算视图的高
    CGFloat photoesH = ((configure.maxCount-1) / configure.column + 1) * (itemWH + configure.itemMargin) - configure.itemMargin + configure.photoesInsets.top + configure.photoesInsets.bottom;
    
    XCPhotoesView *photoesView = [[XCPhotoesView alloc] initWithFrame:CGRectMake(0, 0, configure.photoesWidth, photoesH)];
    
    photoesView.photoWH    = itemWH;
    photoesView.configure  = configure;
    photoesView.models     = models;
    
    [photoesView.addButton setImage:configure.addImage forState:UIControlStateNormal];
    
    
    photoesView.didClickDeleteButtonHandle = didClickDeleteButtonHandle;
    photoesView.didClickAddButtonHnadle    = didClickAddButtonHandle;
    photoesView.didSelectItemHandle        = didSelectItemHandle;
    
    return photoesView;
}

/**
 *  删除 item
 *
 *  @param item  要删除的 item
 *  @param model 对应的 模型
 */
- (void)deleteItem:(XCPhotoItem *)item model:(XCPhotoModel *)model
{
    __weak typeof(self)weakSelf = self;
    
    NSInteger index = [self.models indexOfObject:model];
    
    // 删除本个模型
    [self.models removeObject:model];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration            = 0.3;
    animation.fromValue           = @1;
    animation.toValue             = @0;
    animation.fillMode            = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [item.layer addAnimation:animation forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [item removeFromSuperview];
        [weakSelf setNeedsLayout];
        
        // 删除后回调
        if (weakSelf.didClickDeleteButtonHandle)
        {
            weakSelf.didClickDeleteButtonHandle(weakSelf, index);
        }
    });
}

#pragma mark - 🎬 👀 Action Method 👀

/**
 *  点击了添加按钮
 */
- (void)onClickedAddButton
{
    if (self.didClickAddButtonHnadle)
    {
        self.didClickAddButtonHnadle(self);
    }
}


@end




