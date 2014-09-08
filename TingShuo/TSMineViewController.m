//
//  TSMineViewController.m
//  TingShuo
//
//  Created by fminor on 7/31/14.
//
//

#import "TSMineViewController.h"

NSString *_titles[] = {@"头像", @"昵称", @"年龄", @"我的拍卖", @"我的发布", @"设置"};

@implementation TSMineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:TS_COLOR_BKG];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIColor *_color = [UIColor colorWithRed:(CGFloat)0x16 / 0xff
                                      green:(CGFloat)0x6d / 0xff
                                       blue:(CGFloat)0xb4 / 0xff
                                      alpha:1];
    [self.navigationController.navigationBar setBarTintColor:_color];
    
    UILabel *_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_titleLabel setText:@"我"];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.navigationItem setTitleView:_titleLabel];
    
    _mySettingList = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _mySettingList.delegate = self;
    _mySettingList.dataSource = self;
    [self.view addSubview:_mySettingList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 5: 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == 0 && indexPath.section == 0 ) {
        return 78.f;
    }
    
    return 45.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *_identify = @"__my__";
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:_identify];
    if ( !_cell ) {
        _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_identify];
    }
    
    _cell.backgroundColor = [UIColor whiteColor];
    _cell.textLabel.textColor = TS_COLOR_THEME;
    _cell.textLabel.font = [UIFont fontWithName:nil size:13];
    _cell.textLabel.text = _titles[indexPath.row + indexPath.section * 5];
    
    _cell.detailTextLabel.text = @"test";
    
    [_cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return _cell;
}

@end
