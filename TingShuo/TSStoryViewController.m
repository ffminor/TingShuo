//
//  TSStoryViewController.m
//  TingShuo
//
//  Created by fminor on 8/4/14.
//
//

#import "TSStoryViewController.h"
#import "TSHomeStoryCell.h"

@implementation TSStoryViewController

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setHidden:NO];
    
    UIColor *_color = [UIColor colorWithRed:(CGFloat)0x16 / 0xff
                                      green:(CGFloat)0x6d / 0xff
                                       blue:(CGFloat)0xb4 / 0xff
                                      alpha:1];
    [self.navigationController.navigationBar setBarTintColor:_color];
    
    NSDictionary *_attrs = @{ NSForegroundColorAttributeName:[UIColor whiteColor] };
    [self.navigationController.navigationBar setTitleTextAttributes:_attrs];
    self.title = @"拍卖消息";
    
    UIButton *_navBackButton = [[UIButton alloc]
                                initWithFrame:CGRectMake(0, 0, 12, 20.5)];
    [_navBackButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [_navBackButton addTarget:self action:@selector(_eventBack)
             forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_leftItem = [[UIBarButtonItem alloc] initWithCustomView:_navBackButton];
    self.navigationItem.leftBarButtonItem = _leftItem;
    
    _storyList = [[UITableView alloc] initWithFrame:self.view.bounds
                                                style:UITableViewStylePlain];
    [_storyList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_storyList setBackgroundColor:TS_COLOR_BKG];
    _storyList.delegate = self;
    _storyList.dataSource = self;
    [self.view addSubview:_storyList];
    
    [self.view setBackgroundColor:TS_COLOR_BKG];
}

#pragma mark - table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *_identifier = @"story_cell_story";
    TSHomeStoryCell *_cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    if ( !_cell ) {
        _cell = [[TSHomeStoryCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:_identifier];
    }
    return _cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSHomeStoryCell *_nc = (TSHomeStoryCell *)cell;
    [_nc.titleLabel setText:@"邱特"];
    [_nc.detailLabel setText:@"拓扑学（tuò pū xué)（topology）是近代发展起来的一个数学分支，用来研究各种“空间”在连续性的变化下不变的性质。在20世纪，拓扑学发展成为数学中一个非常重要的领域。有关拓扑学的一些内容早在十八世纪就出现了。"];
    _nc.timeLabel.text = @"32分钟前";
    _nc.responseLabel.text = @"12345条回复";
    [_nc hideMoreIcon:YES];
}

#pragma mark - navigation controller

- (void)_eventBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
