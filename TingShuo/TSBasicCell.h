//
//  TSBasicCell.h
//  TingShuo
//
//  Created by fminor on 7/20/14.
//
//

#import <UIKit/UIKit.h>

@interface TSBasicCell : UITableViewCell
{
    UIView                      *_containerView;
    UIImageView                 *_iconView;
    UILabel                     *_titleLabel;
    UIImageView                 *_moreIconView;
}

@property (nonatomic, readonly) UILabel             *titleLabel;
@property (nonatomic, readonly) UIImageView         *iconView;
@property (nonatomic, readonly) UIView              *containerView;

- (void)willDisplayCell;

@end
