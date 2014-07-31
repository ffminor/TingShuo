//
//  TSAuctionInfoCell.h
//  TingShuo
//
//  Created by fminor on 7/31/14.
//
//

#import "TSBasicCell.h"

@interface TSAuctionInfoCell : TSBasicCell
{
    UILabel                         *_subtitleLabel;
    UIImageView                     *_iconImageView;
    UILabel                         *_timeLabel;
}

@property (nonatomic, readonly) UILabel         *subtitleLabel;

@property (nonatomic, readonly) UILabel         *timeLabel;

@end
