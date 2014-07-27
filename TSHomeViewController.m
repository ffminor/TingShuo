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
    
    _tableView = [[UITableView alloc] init];
    [_tableView setBackgroundColor:[UIColor grayColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    if ( indexPath.row == 0 ) {
        [_cell.titleLabel setText:@"1条拍卖信息"];
    }
    
    if ( indexPath.row == 1 ) {
        [_cell.titleLabel setText:@"10条新信息"];
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
