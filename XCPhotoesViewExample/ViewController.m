//
//  ViewController.m
//  XCPhotoesViewExample
//
//  Created by 樊小聪 on 2017/3/13.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "ViewController.h"
#import "TTTViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 🚀 ⛳️ Navigation Jump ⛳️

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TTTViewController *vc = segue.destinationViewController;
    vc.isLocal = [segue.identifier isEqualToString:@"Local"];
}


@end




















