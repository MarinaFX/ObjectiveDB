//
//  ViewController.m
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 21/03/22.
//

#import "ViewController.h"
#import "model/Movie.h"
#import "service/MovieService.h"
#import "Views/MovieTableCell.h"
#import "MovieDetailViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *nowPlayingMovies;
@property (nonatomic, retain) NSArray *popularMovies;
@property (nonatomic, retain) NSArray *moviePosters;
@property (nonatomic, retain) MovieService *service;

@end

@implementation ViewController

static NSString *const BASE_IMG_URL = @"https://image.tmdb.org/t/p/w342";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    self.service = [[MovieService alloc] init];
    self.nowPlayingMovies = [[NSArray alloc] init];
    self.popularMovies = [[NSArray alloc] init];
    self.moviePosters = [[NSArray alloc] init];
    
    [self.service performAsyncMoviesDownloadWithType: @"now_playing" completionBlock:^(BOOL success, NSMutableArray *movies) {
        if (success) {
            self.nowPlayingMovies = movies;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
    [self.service performAsyncMoviesDownloadWithType: @"popular" completionBlock:^(BOOL success, NSMutableArray *movies) {
        if (success) {
            self.popularMovies = movies;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqual: @"toDetails"] && sender != nil) {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        MovieDetailViewController *destination = segue.destinationViewController;
        
        if (indexPath.section == 0) {
            destination.movie = _popularMovies[indexPath.row];
        }
        else {
            destination.movie = _nowPlayingMovies[indexPath.row];
        }
    }
}

//MARK: - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toDetails" sender:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title = @"";
    
    if (section == 0) {
        title = @"Popular";
    }
    else {
        title = @"Now Playing";
    }
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [header setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.view.frame.size.width, 22)];
    [label setFont:[UIFont systemFontOfSize:17 weight:UIFontWeightBold]];
    [label setText:title];
    
    [header addSubview:label];
    
    return header;
}

//MARK: - DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [_popularMovies count];
    }
    return [_nowPlayingMovies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieTableCell"];
    
    if (cell == nil) {
        cell = (MovieTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MovieTableCell"];        
    }
    
    Movie *currentMovie = indexPath.section == 0 ? _popularMovies[indexPath.row] : _nowPlayingMovies[indexPath.row];
    
    NSString *posterURL = [NSString stringWithFormat:@"%@%@", BASE_IMG_URL, [currentMovie posterPath]];
    
    [self.service performAsyncImageDownloadWithURL:posterURL completionBlock:^(BOOL success, UIImage *image) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [currentMovie setMoviePoster:image];
            });
        }
    }];
    
    cell.moviePoster.image = [currentMovie moviePoster];
    cell.movieTitleLabel.text = [currentMovie title];
    cell.movieOverviewLabel.text = [currentMovie overview];
    cell.movieRatingLabel.text = [[currentMovie rating] stringValue];
    
    return cell;
}

@end
