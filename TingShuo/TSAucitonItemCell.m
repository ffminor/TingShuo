//
//  TSAucitonItemCell.m
//  TingShuo
//
//  Created by fminor on 8/17/14.
//
//

#import "TSAucitonItemCell.h"

@implementation TSAucitonItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if ( self ) {
        _itemNameLabel = [[UILabel alloc] init];
        [_itemNameLabel setFont:[UIFont fontWithName:nil size:14]];
        [_itemNameLabel setFrame:CGRectMake(100, 10, 200, 14)];
        [_itemNameLabel setText:@"苹果 iPod touch 16G"];
        [self addSubview:_itemNameLabel];
        
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setFont:[UIFont fontWithName:nil size:12]];
        [_priceLabel setFrame:CGRectMake(100, 30, 200, 12)];
        [_priceLabel setText:@"当前价格：1000金币"];
        [self addSubview:_priceLabel];
        
        _capicityLabel = [[UILabel alloc] init];
        [_capicityLabel setFont:[UIFont fontWithName:nil size:12]];
        [_capicityLabel setFrame:CGRectMake(100, 50, 200, 12)];
        [_capicityLabel setText:@"数量：3个"];
        [self addSubview:_capicityLabel];
        
        _remainedTimeLabel = [[UILabel alloc] init];
        [_remainedTimeLabel setFont:[UIFont fontWithName:nil size:12]];
        [_remainedTimeLabel setFrame:CGRectMake(100, 75, 200, 12)];
        [_remainedTimeLabel setText:@"剩余时间：1天2小时30分"];
        [self addSubview:_remainedTimeLabel];
        
        _demandButton = [[UIButton alloc] init];
        [_demandButton setFrame:CGRectMake(250, 50, 60, 30)];
        [_demandButton.titleLabel setFont:[UIFont fontWithName:nil size:14]];
        [_demandButton setTitleColor:CUSTOM_COLOR_THEME forState:UIControlStateNormal];
        [_demandButton setTitle:@"出价" forState:UIControlStateNormal];
        [self addSubview:_demandButton];
    }
    
    return self;
}

@end
