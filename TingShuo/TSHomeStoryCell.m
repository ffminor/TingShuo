//
//  TSHomeStoryCell.m
//  TingShuo
//
//  Created by fminor on 8/3/14.
//
//

#import "TSHomeStoryCell.h"

@implementation TSHomeStoryCell

@synthesize detailLabel = _detailLabel;
@synthesize responseLabel = _responseLabel;
@synthesize timeLabel = _timeLabel;
@synthesize titleIconView = _titleIconView;
@synthesize zansLabel = _zansLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        _titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_story_icon.png"]];
        [_containerView addSubview:_titleIconView];
        
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_detailLabel setNumberOfLines:0];
        [_detailLabel setTextColor:[UIColor grayColor]];
        [_detailLabel setTextAlignment:NSTextAlignmentLeft];
        [_detailLabel setFont:[UIFont fontWithName:nil size:12]];
        [_containerView addSubview:_detailLabel];
        
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setFont:[UIFont fontWithName:nil size:12.f]];
        [_timeLabel setTextColor:[UIColor colorWithWhite:0.4 alpha:1]];
        [_timeLabel setTextAlignment:NSTextAlignmentRight];
        [_containerView addSubview:_timeLabel];
        
        _responseLabel = [[UILabel alloc] init];
        [_responseLabel setFont:[UIFont fontWithName:nil size:10.f]];
        [_responseLabel setTextColor:TS_COLOR_THEME];
        [_responseLabel setTextAlignment:NSTextAlignmentRight];
        [_containerView addSubview:_responseLabel];
        
        _zanIconView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_zan.png"]];
        [_containerView addSubview:_zanIconView];

        _zansLabel = [[UILabel alloc] init];
        [_zansLabel setFont:[UIFont fontWithName:nil size:10.f]];
        [_zansLabel setTextColor:TS_COLOR_THEME];
        [_zansLabel setTextAlignment:NSTextAlignmentCenter];
        [_containerView addSubview:_zansLabel];
    }
    
    [_titleLabel setFont:[UIFont fontWithName:nil size:12]];
    [_titleLabel setTextColor:[UIColor blackColor]];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_titleIconView setFrame:CGRectMake(5, 5,
                                        _titleIconView.frame.size.width,
                                        _titleIconView.frame.size.height)];
    [_titleLabel setFrame:CGRectMake(_titleIconView.frame.size.width + 15,
                                     _titleIconView.frame.origin.y,
                                     0.7 * _containerView.frame.size.width,
                                     _titleIconView.frame.size.height)];
    [_timeLabel setFrame:CGRectMake(0.5 * _containerView.frame.size.width,
                                    _titleLabel.frame.origin.y,
                                    0.5 * _containerView.frame.size.width - 15,
                                    _titleLabel.frame.size.height)];
    [_detailLabel setFrame:CGRectMake(15,
                                      _titleLabel.frame.size.height,
                                      _containerView.frame.size.width - 30,
                                      _containerView.frame.size.height * 0.7)];
    [_responseLabel setFrame:CGRectMake(0,
                                        _containerView.frame.size.height - 20,
                                        _containerView.frame.size.width - 15 - 60,
                                        10)];
    [_zansLabel setFrame:CGRectMake(_containerView.frame.size.width - 60,
                                    _containerView.frame.size.height - 20,
                                    40,
                                    10)];
    [_zanIconView setFrame:CGRectMake(_containerView.frame.size.width - 20,
                                      _containerView.frame.size.height - 20,
                                      _zanIconView.frame.size.width,
                                      _zanIconView.frame.size.height)];
    
}

@end
