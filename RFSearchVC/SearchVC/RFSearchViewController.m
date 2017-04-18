//
//  RFSearchViewController.m
//  RFSearchVC
//
//  Created by rocky on 2017/4/18.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import "RFSearchViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#define kWindow [UIApplication sharedApplication].keyWindow
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface RFSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic , strong)UISearchBar * searchBar;
@property(nonatomic , strong)UITableView * tableView;
@property(nonatomic , strong)UIView * headView;
@property(nonatomic , strong)NSMutableArray * serverDataArr;
@end

@implementation RFSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.5];
    [self setUpSearch];
}
- (NSMutableArray *)serverDataArr
{
    if (_serverDataArr == nil) {
        _serverDataArr = [NSMutableArray array];
    }
    return _serverDataArr;
}
- (UIView *)headView
{
    if (_headView == nil) {
        _headView = [[UIView alloc]init];
        _headView.frame = CGRectMake(0, 0, kScreenW, 20);
        _headView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }
    return _headView;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.frame = CGRectMake(0, 20, kScreenW, 44);
        [_searchBar setBackgroundImage:[UIImage imageNamed:@"ic_searchBar_bgImage"]];
        [_searchBar sizeToFit];
        [_searchBar setPlaceholder:@"search for"];
        [_searchBar setDelegate:self];
        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
        [_searchBar setTranslucent:YES];//设置是否透明
        [_searchBar setSearchBarStyle:UISearchBarStyleDefault];
        [_searchBar setShowsCancelButton:YES];
        _searchBar.tintColor = [UIColor orangeColor];
        
    }
    return _searchBar;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0, 64, kScreenW, kScreenH - 64);
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    return _tableView;
    
}
- (void)setUpSearch
{
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    self.navigationItem.titleView = self.searchBar;
    [self.navigationItem setHidesBackButton:YES]; // 隐藏返回按钮
    [_searchBar becomeFirstResponder]; // 成为第一焦点
    [self.serverDataArr addObjectsFromArray:self.dataArray];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.serverDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_serverDataArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击 %@",self.serverDataArr[indexPath.row]);
    if (self.searchTextBlock) {
        self.searchTextBlock(self.serverDataArr[indexPath.row]);
    }
    [self hidden];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"输入 %@",searchText);
    [self.serverDataArr removeAllObjects];
    if (searchText.length == 0) {
        [self.serverDataArr addObjectsFromArray:self.dataArray];
        [self.tableView reloadData];
        return;
    }
    [self filterContentForSearchText:searchText scope:self.searchBar.scopeButtonTitles[1]];
}

#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        NSString * storeString = self.dataArray[i];
        NSRange storeRange = NSMakeRange(0, storeString.length);
        
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        
        if (foundRange.length) {
            [tempResults addObject:storeString];
        }
    }
    [self.serverDataArr addObjectsFromArray:tempResults];
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self hidden];
    
}
- (void)hidden
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"没有数据";
    return [[NSAttributedString alloc] initWithString:text attributes:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
