//
//  PresentationTableCell.m
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 23/03/22.
//

#import <Foundation/Foundation.h>
#import "PresentationTableCell.h"

@implementation PresentationTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.moviePoster.layer setCornerRadius:15];
    
    [self.starImage setTintColor:[UIColor systemGrayColor]];
    [self.movieDetails setTextColor:[UIColor systemGrayColor]];
    [self.movieRating setTextColor:[UIColor systemGrayColor]];
}

@end
