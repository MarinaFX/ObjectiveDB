//
//  ViewController.h
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 21/03/22.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

- (UIViewController*) topMostController;

@end

