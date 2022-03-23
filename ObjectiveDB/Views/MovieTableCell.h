//
//  MovieTableCell.h
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 23/03/22.
//
#import <UIKit/UIKit.h>
#ifndef MovieTableCell_h
#define MovieTableCell_h


#endif /* MovieTableCell_h */

@interface MovieTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieOverviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRatingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starImage;

@end
