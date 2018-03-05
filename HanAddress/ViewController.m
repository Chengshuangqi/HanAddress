//
//  ViewController.m
//  HanAddress
//
//  Created by 123 on 2018/2/28.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "ViewController.h"
#import "CSAddressView.h"

@interface ViewController ()<CSAddressViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CSAddressView *add = [[CSAddressView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    add.delegate = self;
    [self.view addSubview:add];
    
}

- (void)CSAddressView:(CSAddressView *)view withDidSelectIndex:(NSInteger)index withAddressProvince:(NSString *)province city:(NSString *)city district:(NSString *)district
{
    if (index == 0)
    {
        NSLog(@"取消");
    }
    else
    {
        NSLog(@"---->%@ --->%@ --->%@",province,city,district);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
