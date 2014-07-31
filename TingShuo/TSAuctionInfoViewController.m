//
//  TSAuctionInfoViewController.m
//  TingShuo
//
//  Created by fminor on 7/20/14.
//
//

#import "TSAuctionInfoViewController.h"
#import "TSAuctionInfoCell.h"

@implementation TSAuctionInfoViewController

- (void)viewDidLoad
{
    self.title = @"拍卖消息";
    
    NSDictionary *_attrs = @{ NSForegroundColorAttributeName:[UIColor whiteColor] };
    [self.navigationController.navigationBar setTitleTextAttributes:_attrs];
    
    UIButton *_navBackButton = [[UIButton alloc]
                                initWithFrame:CGRectMake(0, 0, 12, 20.5)];
    [_navBackButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [_navBackButton addTarget:self action:@selector(_eventBack)
             forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_leftItem = [[UIBarButtonItem alloc] initWithCustomView:_navBackButton];
    self.navigationItem.leftBarButtonItem = _leftItem;
    
    _auctionList = [[UITableView alloc] initWithFrame:self.view.bounds
                                                style:UITableViewStylePlain];
    [_auctionList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_auctionList setBackgroundColor:CUSTOM_COLOR_BKG];
    _auctionList.delegate = self;
    _auctionList.dataSource = self;
    [self.view addSubview:_auctionList];
    
    [self.view setBackgroundColor:CUSTOM_COLOR_BKG];
}

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *_identify = @"tsauctioncell";
    TSAuctionInfoCell *_cell = [tableView dequeueReusableCellWithIdentifier:_identify];
    if ( !_cell ) {
        _cell = [[TSAuctionInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identify];
    }
    return _cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSAuctionInfoCell *_cell = (TSAuctionInfoCell *)cell;
    [_cell willDisplayCell];
    _cell.titleLabel.text = @"拍卖消息";
    _cell.subtitleLabel.text = @"您已成功拍下xxx";
    _cell.timeLabel.text = @"3小时前";
}

#pragma mark - navigation controller

- (void)_eventBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
