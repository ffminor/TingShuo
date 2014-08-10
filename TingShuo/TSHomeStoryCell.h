//
//  TSHomeStoryCell.h
//  TingShuo
//
//  Created by fminor on 8/3/14.
//
//

#import <Foundation/Foundation.h>
#import "TSBasicCell.h"

@interface TSHomeStoryCell : TSBasicCell
{
    UILabel                     *_detailLabel;
    UIImageView                 *_titleIconView;
    UILabel                     *_timeLabel;
    UILabel                     *_responseLabel;
}

@property (nonatomic, readonly) UILabel             *detailLabel;
@property (nonatomic, readonly) UIImageView         *titleIconView;
@property (nonatomic, readonly) UILabel             *timeLabel;
@property (nonatomic, readonly) UILabel             *responseLabel;

@end
