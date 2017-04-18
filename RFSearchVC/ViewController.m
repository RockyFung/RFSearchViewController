//
//  ViewController.m
//  RFSearchVC
//
//  Created by rocky on 2017/4/18.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import "ViewController.h"
#import "RFSearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 40)];
    btn.backgroundColor = [UIColor brownColor];
    [btn setTitle:@"search" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)search:(UIButton *)btn{
    RFSearchViewController *vc = [[RFSearchViewController alloc]init];
    vc.dataArray = @[@"11223",@"334455",@"178967"];
    vc.searchTextBlock = ^(NSString *searchText){
        [btn setTitle:searchText forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
