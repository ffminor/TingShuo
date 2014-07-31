//
//  TSMineViewController.m
//  TingShuo
//
//  Created by fminor on 7/31/14.
//
//

#import "TSMineViewController.h"

@implementation TSMineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIColor *_color = [UIColor colorWithRed:(CGFloat)0x16 / 0xff
                                      green:(CGFloat)0x6d / 0xff
                                       blue:(CGFloat)0xb4 / 0xff
                                      alpha:1];
    [self.navigationController.navigationBar setBarTintColor:_color];
    
    UILabel *_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_titleLabel setText:@"我"];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [self.navigationItem setTitleView:_titleLabel];
    
}

@end
