//
//  PresentationTableCell.h
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 23/03/22.
//
#import <UIKit/UIKit.h>

#ifndef PresentationTableCell_h
#define PresentationTableCell_h


#endif /* PresentationTableCell_h */

@interface PresentationTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieDetails;
@property (weak, nonatomic) IBOutlet UIImageView *starImage;
@property (weak, nonatomic) IBOutlet UILabel *movieRating;

@end
