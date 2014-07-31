//
//  TSHomeViewController.h
//  TingShuo
//
//  Created by fminor on 6/15/14.
//
//

#import <UIKit/UIKit.h>

@interface TSHomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView                     *_tableView;
    UIBarButtonItem                 *_plusButton;
}

@end
