//
//  RFSearchViewController.h
//  RFSearchVC
//
//  Created by rocky on 2017/4/18.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFSearchViewController : UIViewController
@property(nonatomic , strong)NSArray * dataArray;
@property (nonatomic, copy) void(^searchTextBlock)(NSString *searchText);
- (void)hidden;

@end
