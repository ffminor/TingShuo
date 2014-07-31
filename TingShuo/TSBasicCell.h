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
    UILabel                     *_titleLabel;
    UIImageView                 *_moreIconView;
}

@property (nonatomic, readonly) UILabel             *titleLabel;

@property (nonatomic, readonly) UIView              *containerView;

@property (nonatomic, readonly) UIImageView         *moreIcon;

- (void)hideMoreIcon:(BOOL)hide;

- (void)willDisplayCell;

@end
