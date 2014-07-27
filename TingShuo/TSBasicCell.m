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
@synthesize iconView = _iconView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        _containerView = [[UIView alloc] init];
        [self addSubview:_containerView];
        
        _titleLabel = [[UILabel alloc] init];
        [_containerView addSubview:_titleLabel];
    }
    
    return self;
}

- (void)willDisplayCell
{
    [self setBackgroundColor:[UIColor grayColor]];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    /*
    UIView *_bkgView = [[UIView alloc] initWithFrame:self.contentView.frame];
    [_bkgView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_bkgView];
    
    CGRect _cntf = self.contentView.frame;
    _cntf.origin.x += 2;
    _cntf.origin.y += 2;
    _cntf.size.width -= 4;
    _cntf.size.height -= 4;
    [self.contentView setFrame:_cntf];
    
    [self bringSubviewToFront:self.contentView];
     */
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect _contentFrame = self.bounds;
    _contentFrame.origin.x = 5;
    _contentFrame.origin.y = 5;
    _contentFrame.size.width -= 10;
    _contentFrame.size.height -= 10;
    [_containerView setFrame:_contentFrame];
    
    [_titleLabel setFrame:_containerView.bounds];
    
}

@end
