//
//  ViewController.m
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2017/3/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "ViewController.h"

#import "XCPhotoesView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}

- (void)setupUI
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
    
    XCPhotoesView *photoesView = [XCPhotoesView photoesViewWithImages:mArr configure:configure didClickAddButtonHnadle:^(XCPhotoesView *photoesView) {
        
        NSLog(@"点击了 添加 按钮");
        
    } didClickDeleteButtonHandle:^(XCPhotoesView *photoesView, NSInteger index) {
        
        NSLog(@"点击了 删除 按钮");
        
    } didSelectItemHandle:^(XCPhotoesView *photoesView, NSInteger index) {
        
        NSLog(@"%@", [NSString stringWithFormat:@"选中了%zi张照片", index]);
    }];
    
    [self.view addSubview:photoesView];
}


@end




















