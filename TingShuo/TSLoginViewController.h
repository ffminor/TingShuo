//
//  TSLoginViewController.h
//  TingShuo
//
//  Created by fminor on 8/31/14.
//
//

#import <UIKit/UIKit.h>

extern NSString *TSLoginServerUrl;

@interface TSLoginViewController : UIViewController
{
    UIImageView                     *_backgroundImageView;
    UITextField                     *_userNameTextField;
    UITextField                     *_passwordTextField;
}

@end
