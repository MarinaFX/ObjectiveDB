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
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.moviePoster.layer setCornerRadius:15];
    [self.moviePoster setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.movieOverviewLabel setTextColor:[UIColor systemGrayColor]];
    [self.starImage setTintColor:[UIColor systemGrayColor]];
    [self.movieRatingLabel setTextColor:[UIColor systemGrayColor]];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self setNeedsLayout];
    
    [self setNeedsDisplay];
}
@end
