//
//  TSHomeViewController.m
//  TingShuo
//
//  Created by fminor on 6/15/14.
//
//

#import "TSHomeViewController.h"
#import "TSBasicCell.h"
#import "TSAuctionInfoViewController.h"

@implementation TSHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIColor *_color = [UIColor colorWithRed:(CGFloat)0x16 / 0xff
                                      green:(CGFloat)0x6d / 0xff
                                       blue:(CGFloat)0xb4 / 0xff
                                      alpha:1];
    [self.navigationController.navigationBar setBarTintColor:_color];
    UIImageView *_titleView = [[UIImageView alloc]
                               initWithImage:[UIImage imageNamed:@"nav_title.png"]];
    [self.navigationItem setTitleView:_titleView];
    
    UIButton *_topRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [_topRight setFrame:CGRectMake(0, 0, 23, 23)];
    [_topRight setImage:[UIImage imageNamed:@"nav_plus.png"] forState:UIControlStateNormal];
    _plusButton = [[UIBarButtonItem alloc] initWithCustomView:_topRight];
    self.navigationItem.rightBarButtonItem = _plusButton;
    
    _tableView = [[UITableView alloc] init];
    [_tableView setBackgroundColor:CUSTOM_COLOR_BKG];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView setFrame:self.view.bounds];
}

#pragma mark --
#pragma mark -- tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row > 1 ) {
        return 150.f;
    }
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *_identifier = nil;
    if ( indexPath.row <= 1 ) {
        _identifier = @"basic_info";
    } else {
        _identifier = @"detail_info";
    }
    TSBasicCell *_cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    if ( !_cell ) {
        _cell = [[TSBasicCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:_identifier];
    }
    
    return _cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSBasicCell *_cell = (TSBasicCell *)cell;
    [_cell willDisplayCell];
    if ( indexPath.row == 0 ) {
        [_cell.titleLabel setText:@"1条拍卖信息"];
    }
    
    if ( indexPath.row == 1 ) {
        [_cell.titleLabel setText:@"10条新信息"];
    }
    
    if ( indexPath.row > 1 ) {
        [_cell hideMoreIcon:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ( indexPath.row == 0 ) {
        TSAuctionInfoViewController *_aivc = [[TSAuctionInfoViewController alloc] init];
        [self.navigationController pushViewController:_aivc animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
