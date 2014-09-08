//
//  TSBasicCell.m
//  TingShuo
//
//  Created by fminor on 7/20/14.
//
//

#import "TSBasicCell.h"

@implementation TSBasicCell

@synthesize titleLabel = _titleLabel;
@synthesize containerView = _containerView;
@synthesize moreIcon = _moreIconView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        _containerView = [[UIView alloc] init];
        [self addSubview:_containerView];
        
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont fontWithName:nil size:15]];
        [_containerView addSubview:_titleLabel];
        
        _moreIconView = [[UIImageView alloc] init];
        [_moreIconView setImage:[UIImage imageNamed:@"icon_more.png"]];
        [_moreIconView setHidden:YES];
        [_containerView addSubview:_moreIconView];
    }
    
    return self;
}

- (void)willDisplayCell
{
    [self setBackgroundColor:TS_COLOR_BKG];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect _contentFrame = self.bounds;
    _contentFrame.origin.x = 10;
    _contentFrame.origin.y = 5;
    _contentFrame.size.width -= 20;
    _contentFrame.size.height -= 10;
    [_containerView setFrame:_contentFrame];
    
    CGRect _titleFrame = _containerView.bounds;
    _titleFrame.origin.x = 10;
    [_titleLabel setFrame:_titleFrame];
    
    CGRect _iconFrame = _containerView.bounds;
    _iconFrame.origin.x = _iconFrame.size.width - 5.5 - 15;
    _iconFrame.origin.y = ( _iconFrame.size.height - 8.5 ) * 0.5;
    _iconFrame.size.width = 5.5;
    _iconFrame.size.height = 8.5;
    [_moreIconView setFrame:_iconFrame];
}

- (void)hideMoreIcon:(BOOL)hide
{
    [_moreIconView setHidden:hide];
}

@end
