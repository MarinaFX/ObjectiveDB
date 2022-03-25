//
//  MovieDetailViewController.m
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 23/03/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MovieDetailViewController.h"
#import "PresentationTableCell.h"
#import "MovieOverviewTableCell.h"
#import "model/Movie.h"

@interface MovieDetailViewController () <UITableViewDataSource> {
    
}

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setDataSource:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        PresentationTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MoviePresentationCell"];
        
        if (cell == nil) {
            cell = (PresentationTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoviePresentationCell"];
        }
        
        //recebe por segue
        cell.moviePoster.image = [self.movie moviePoster];
        cell.movieTitle.text = [self.movie title];
        cell.movieDetails.text = [self.movie overview];
        cell.movieRating.text = [[self.movie rating] stringValue];
        
        return cell;
    }
    else {
        MovieOverviewTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieOverviewCell"];
        
        if (cell == nil) {
            cell = (MovieOverviewTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MovieOverviewCell"];
        }
        
        //recebe por segue
        cell.movieOverview.text = [self.movie overview];
        
        return cell;
    }
}

@end
