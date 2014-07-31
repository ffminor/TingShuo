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
    [super viewDidLoad];
    
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
