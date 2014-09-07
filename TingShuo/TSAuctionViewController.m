//
//  TSAuctionViewController.m
//  TingShuo
//
//  Created by fminor on 8/17/14.
//
//

#import "TSAuctionViewController.h"
#import "TSAucitonItemCell.h"

@implementation TSAuctionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // navigation
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIColor *_color = [UIColor colorWithRed:(CGFloat)0x16 / 0xff
                                      green:(CGFloat)0x6d / 0xff
                                       blue:(CGFloat)0xb4 / 0xff
                                      alpha:1];
    [self.navigationController.navigationBar setBarTintColor:_color];
    
    UILabel *_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_titleLabel setText:@"拍卖"];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.navigationItem setTitleView:_titleLabel];
    
    UIButton *_ruleDesc = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ruleDesc setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_ruleDesc setTitle:@"规则说明" forState:UIControlStateNormal];
    [_ruleDesc.titleLabel setFont:[UIFont fontWithName:nil size:12]];
    [_ruleDesc setFrame:CGRectMake(0, 0, 96, 48)];
    UIBarButtonItem *_barItem = [[UIBarButtonItem alloc] initWithCustomView:_ruleDesc];
    [self.navigationItem setRightBarButtonItem:_barItem];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *_identifier = @"ts_auction";
    TSAucitonItemCell *_cell = (TSAucitonItemCell *)[tableView dequeueReusableCellWithIdentifier:_identifier];
    if ( !_cell ) {
        _cell = [[TSAucitonItemCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:_identifier];
    }
    return _cell;
}

@end
