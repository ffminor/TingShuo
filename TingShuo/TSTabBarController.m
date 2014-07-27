//
//  TSTabBarController.m
//  TingShuo
//
//  Created by fminor on 6/15/14.
//
//

#import "TSTabBarController.h"

@implementation TSTabBarController

- (void)viewDidLoad
{
    [super didReceiveMemoryWarning];

    UIColor *_color = [UIColor colorWithRed:(CGFloat)0x16 / 0xff
                                      green:(CGFloat)0x6d / 0xff
                                       blue:(CGFloat)0xb4 / 0xff
                                      alpha:1];
    [self.navigationController.navigationBar setBarTintColor:_color];
    UIImageView *_titleView = [[UIImageView alloc]
                               initWithImage:[UIImage imageNamed:@"nav_title.png"]];
    [self.navigationItem setTitleView:_titleView];
    
    NSArray *_tabTitleArray = @[@"听说", @"拍卖", @"我的"];
    
    [self.tabBar setBackgroundColor:[UIColor blueColor]];
    
    for ( int i = 0 ; i < 3 ; i++ ) {
        UITabBarItem *_item = [self.tabBar.items objectAtIndex:i];
        _item.title = [_tabTitleArray objectAtIndex:i];
        [_item setImage:[UIImage
                         imageNamed:[NSString
                                     stringWithFormat:@"tabbar_image%d_normal.png", i]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
