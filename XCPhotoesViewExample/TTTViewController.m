//
//  TTTViewController.m
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2018/5/29.
//  Copyright © 2018年 樊小聪. All rights reserved.
//

#import "TTTViewController.h"
#import "XCPhotoesView.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface TTTViewController ()

@property (weak, nonatomic) IBOutlet UIView *imgContainerView;

@end

@implementation TTTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /// 设置 UI
    [self setupUI];
}

#pragma mark - ✏️ 🖼 SetupUI Method 🖼

- (void)setupUI
{
    if (self.isLocal) {
        /// 设置本地图片
        [self setupLocalView];
    } else {
        /// 设置网页图片
        [self setupWebView];
    }
}

/**
 *  设置本地图片
 */
- (void)setupLocalView
{
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSInteger i=1; i<10; i ++)
    {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%zi.jpg", i]];
        [mArr addObject:img];
    }
    
    XCPhotoesConfigure *configure = [XCPhotoesConfigure defaultConfigure];
    configure.deleteImage = [UIImage imageNamed:@"icon_delete_grey_default"];
    configure.addImage    = [UIImage imageNamed:@"icon_add_gy_xl"];
    configure.maxCount    = 8;
    configure.photoesWidth = 300;
    
    XCPhotoesView *photoesView = [XCPhotoesView photoesViewWithImages:mArr configure:configure didClickAddButtonHnadle:^(XCPhotoesView *photoesView) {
        
        NSLog(@"点击了 添加 按钮");
        
    } didClickDeleteButtonHandle:^(XCPhotoesView *photoesView, NSInteger index) {
        
        NSLog(@"点击了 删除 按钮");
        
    } didSelectItemHandle:^(XCPhotoesView *photoesView, NSInteger index) {
        
        NSLog(@"%@", [NSString stringWithFormat:@"选中了%zi张照片", index]);
    }];
    
    [self.imgContainerView addSubview:photoesView];
}

/**
 *  设置网页图片
 */
- (void)setupWebView
{
    NSArray *URLs = @[
                      @"http://img.zcool.cn/community/0117e2571b8b246ac72538120dd8a4.jpg",
                      @"http://pic21.photophoto.cn/20111011/0006019003288114_b.jpg",
                      @"http://pic.58pic.com/58pic/16/69/38/80258PICuUb_1024.jpg",
                      @"http://pic23.nipic.com/20120821/2572038_132424529000_2.jpg",
                      @"http://pic.90sjimg.com/back_pic/qk/back_origin_pic/00/04/28/cffa590ca64b63ac4294886f823b449c.jpg",
                      @"http://img03.tooopen.com/images/20131102/sy_45238929299.jpg",
                      @"http://www.fm086.com/kind/attached/image/20130416/20130416145875307530.jpg",
                      @"http://img05.tooopen.com/images/20140408/sy_58334427263.jpg",
                      @"http://pic2.ooopic.com/11/90/43/67b2OOOPIC7b_1024.jpg"
                      ];
    
    XCPhotoesConfigure *configure = [XCPhotoesConfigure defaultConfigure];
    configure.deleteImage = [UIImage imageNamed:@"icon_delete_grey_default"];
    configure.addImage    = [UIImage imageNamed:@"icon_add_gy_xl"];
    configure.photoesViewType = XCPhotoesViewTypeDisPlay;
    configure.photoesWidth = 300;
    
    XCPhotoesView *photoesView = [XCPhotoesView photoesViewWithURLs:URLs configure:configure didClickAddButtonHnadle:^(XCPhotoesView *photoesView) {
        
        NSLog(@"点击了 添加 按钮");
        
    } didClickDeleteButtonHandle:^(XCPhotoesView *photoesView, NSInteger index) {
        
        NSLog(@"点击了 删除 按钮");
        
    } didSelectItemHandle:^(XCPhotoesView *photoesView, NSInteger index) {
        
        NSLog(@"%@", [NSString stringWithFormat:@"选中了%zi张照片", index]);
    }];
    
    /// 加载网络图片
    [photoesView configureWebImage:^(UIImageView *imageView, NSURL *URL) {
        [imageView sd_setImageWithURL:URL];
    }];
    
    [self.imgContainerView addSubview:photoesView];
}

@end
