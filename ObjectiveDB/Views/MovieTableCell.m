//
//  MovieTableCell.m
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 23/03/22.
//

#import <Foundation/Foundation.h>
#import "MovieTableCell.h"

@implementation MovieTableCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.moviePoster.layer setCornerRadius:15];
    [self.movieOverviewLabel setTextColor:[UIColor systemGrayColor]];
    [self.starImage setTintColor:[UIColor systemGrayColor]];
    [self.movieRatingLabel setTextColor:[UIColor systemGrayColor]];
}
@end
