//
//  MovieOverviewTableCell.m
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 23/03/22.
//

#import <Foundation/Foundation.h>
#import "MovieOverviewTableCell.h"

@implementation MovieOverviewTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.titleLabel setText:@"Overview"];
    [self.movieOverview setTextColor:[UIColor systemGrayColor]];
}

@end
