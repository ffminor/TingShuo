//
//  TSAuctionInfoCell.m
//  TingShuo
//
//  Created by fminor on 7/31/14.
//
//

#import "TSAuctionInfoCell.h"

@implementation TSAuctionInfoCell

@synthesize subtitleLabel = _subtitleLabel;

@synthesize timeLabel = _timeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        _subtitleLabel = [[UILabel alloc] init];
        [_subtitleLabel setTextColor:TS_COLOR_SUBTILTE];
        [_subtitleLabel setFont:[UIFont fontWithName:nil size:12]];
        [_containerView addSubview:_subtitleLabel];
        
        _iconImageView = [[UIImageView alloc] init];
        [_containerView addSubview:_iconImageView];
        
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setFont:[UIFont fontWithName:nil size:12]];
        [_timeLabel setTextColor:TS_COLOR_SUBTILTE];
        [_timeLabel setTextAlignment:NSTextAlignmentRight];
        [_containerView addSubview:_timeLabel];
        
        [_titleLabel setTextColor:TS_COLOR_THEME];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self hideMoreIcon:YES];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect _titleFrame = _titleLabel.frame;
    _titleFrame.size.height = 0.45 * _titleFrame.size.height;
    _titleFrame.size.width = 0.85 * self.frame.size.width;
    [_titleLabel setFrame:_titleFrame];
    [_timeLabel setFrame:_titleFrame];
    
    _titleFrame.origin.y = 0.4 * self.frame.size.height;
    [_subtitleLabel setFrame:_titleFrame];
}

@end
