//
//  MovieDetailViewController.h
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 23/03/22.
//
#import <UIKit/UIKit.h>
#import "model/Movie.h"

#ifndef MovieDetailViewController_h
#define MovieDetailViewController_h


#endif /* MovieDetailViewController_h */

@interface MovieDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) Movie *movie;


@end
