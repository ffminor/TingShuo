//
//  TSStoryViewController.h
//  TingShuo
//
//  Created by fminor on 8/4/14.
//
//

#import <UIKit/UIKit.h>

@interface TSStoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView                     *_storyList;
}

@end
