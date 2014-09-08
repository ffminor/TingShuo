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
#import "TSHomeStoryCell.h"

#import "TSStoryViewController.h"

@implementation TSHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] init];
    [_tableView setBackgroundColor:TS_COLOR_BKG];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController navigationBar] setHidden:YES];
    
    CGRect _frame = self.view.bounds;
    _frame.size.height -= self.tabBarController.tabBar.frame.size.height;
    [_tableView setFrame:_frame];
    
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
}

#pragma mark --
#pragma mark -- tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
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
    if ( indexPath.row < 2 ) {
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
    } else {
        NSString *_identifier = @"story_cell";
        TSHomeStoryCell *_cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
        if ( !_cell ) {
            _cell = [[TSHomeStoryCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:_identifier];
        }
        return _cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSBasicCell *_cell = (TSBasicCell *)cell;
    [_cell willDisplayCell];
    if ( indexPath.row == 0 ) {
        [_cell.titleLabel setText:@"1条拍卖信息"];
        [_cell hideMoreIcon:NO];
    }
    
    if ( indexPath.row == 1 ) {
        [_cell.titleLabel setText:@"10条新信息"];
        [_cell hideMoreIcon:NO];
    }
    
    if ( indexPath.row > 1 ) {
        TSHomeStoryCell *_nc = (TSHomeStoryCell *)_cell;
        [_nc.titleLabel setText:@"邱特"];
        [_nc.detailLabel setText:@"拓扑学（tuò pū xué)（topology）是近代发展起来的一个数学分支，用来研究各种“空间”在连续性的变化下不变的性质。在20世纪，拓扑学发展成为数学中一个非常重要的领域。有关拓扑学的一些内容早在十八世纪就出现了。"];
        _nc.timeLabel.text = @"32分钟前";
        _nc.responseLabel.text = @"12345条回复";
        _nc.zansLabel.text = @"1234";
        [_nc hideMoreIcon:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ( indexPath.row == 0 ) {
        TSAuctionInfoViewController *_aivc = [[TSAuctionInfoViewController alloc] init];

        UINavigationController *_rootvc = (UINavigationController *)[[[UIApplication sharedApplication] keyWindow] rootViewController];
        [_rootvc pushViewController:_aivc animated:YES];
        //[self.navigationController pushViewController:_aivc animated:YES];
    }
    
    if ( indexPath.row > 1 ) {
        TSStoryViewController *_vc = [[TSStoryViewController alloc] init];
        [self.navigationController pushViewController:_vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
