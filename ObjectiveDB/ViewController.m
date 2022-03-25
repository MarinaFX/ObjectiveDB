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
@property (nonatomic, retain) UISearchController *searchBar;

@property (nonatomic, retain) MovieService *service;

@property (nonatomic, strong) NSMutableArray *popularMovies;
@property (nonatomic, strong) NSMutableArray *nowPlayingMovies;
@property (nonatomic, strong) NSMutableArray *filteredPopularMovies;
@property (nonatomic, strong) NSMutableArray *filteredNowPlayingMovies;
@property (nonatomic, retain) NSMutableArray *moviePosters;

@end

@implementation ViewController

static NSString *const BASE_IMG_URL = @"https://image.tmdb.org/t/p/w342";

- (void)viewDidLoad {
    [super viewDidLoad];

    //MARK: Configuring SearchBar/SearchController
    self.searchBar = [[UISearchController alloc] init];
    
    [self.navigationItem setSearchController:self.searchBar];
    [self.searchBar setSearchResultsUpdater:self];
    [self.searchBar setObscuresBackgroundDuringPresentation:NO];
    
    //Configuring tableView
    [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    //Allocating model arrays
    self.service = [[MovieService alloc] init];
    self.popularMovies = [[NSMutableArray alloc] init];
    self.nowPlayingMovies = [[NSMutableArray alloc] init];
    self.filteredNowPlayingMovies = [[NSMutableArray alloc] init];
    self.filteredPopularMovies = [[NSMutableArray alloc] init];
    self.moviePosters = [[NSMutableArray alloc] init];
    
    //fetching movies/popular
    [self.service performAsyncMoviesDownloadWithType: @"popular" completionBlock:^(BOOL success, NSMutableArray *movies) {
        if (success) {
            self.popularMovies = movies;
            self.filteredPopularMovies = movies;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else {
            [self.topMostController presentViewController:[self setupAlertWithTitle:@"Error" message:@"There was an error while fetching popular movies"] animated: true completion:nil];
        }
    }];
    
    //fetching movies/now_playing
    [self.service performAsyncMoviesDownloadWithType: @"now_playing" completionBlock:^(BOOL success, NSMutableArray *movies) {
        if (success) {
            self.nowPlayingMovies = movies;
            self.filteredNowPlayingMovies = movies;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else {
            [self.topMostController presentViewController:[self setupAlertWithTitle:@"Error" message:@"There was an error while fetching now_playing movies"] animated: true completion:nil];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqual: @"toDetails"] && sender != nil) {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        MovieDetailViewController *destination = segue.destinationViewController;
        
        if (indexPath.section == 0) {
            destination.movie = self.popularMovies[indexPath.row];
        }
        else {
            destination.movie = self.nowPlayingMovies[indexPath.row];
        }
    }
}

-(UIAlertController *) setupAlertWithTitle: (NSString *) title message:(NSString *) message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { }];
    
    [alert addAction:dismissAction];
    
    return alert;
}

//MARK: Topview controller to stack up alerts
- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    return topController;
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
        return [self.filteredPopularMovies count];
    }
    else {
        return [self.filteredNowPlayingMovies count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieTableCell"];
    
    if (cell == nil) {
        cell = (MovieTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MovieTableCell"];        
    }
    
    Movie *currentMovie = indexPath.section == 0 ? self.filteredPopularMovies[indexPath.row] : self.filteredNowPlayingMovies[indexPath.row];
    
    NSString *posterURL = [NSString stringWithFormat:@"%@%@", BASE_IMG_URL, [currentMovie posterPath]];
    
    [self.service performAsyncImageDownloadWithURL:posterURL completionBlock:^(BOOL success, UIImage *image) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [currentMovie setMoviePoster:image];
                [self.tableView reloadData];
            });
        }
    }];
    
    cell.moviePoster.image = [currentMovie moviePoster];
    cell.movieTitleLabel.text = [currentMovie title];
    cell.movieOverviewLabel.text = [currentMovie overview];
    cell.movieRatingLabel.text = [[currentMovie rating] stringValue];
    
    return cell;
}

//MARK: - SearchControllerDelegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [searchController.searchBar text];

    if ([searchText length] == 0) {
        self.filteredPopularMovies = [[NSMutableArray alloc] initWithArray:self.popularMovies];
        
        self.filteredNowPlayingMovies = [[NSMutableArray alloc] initWithArray:self.nowPlayingMovies];
    }
    else {
        [self.filteredPopularMovies removeAllObjects];
        [self.filteredNowPlayingMovies removeAllObjects];

        NSArray *allMovies = [self.popularMovies arrayByAddingObjectsFromArray:self.nowPlayingMovies];
                
        for (Movie *movie in allMovies) {
            NSString *movieTitle = [movie title];
            NSString *loweredCaseTitle = [movieTitle lowercaseString];
            NSString *loweredCaseSearchText = [searchText lowercaseString];
            
            if ([loweredCaseTitle containsString:loweredCaseSearchText]) {

                if ([self.popularMovies containsObject:movie] && ![self.filteredPopularMovies containsObject:movie]) {
                    [self.filteredPopularMovies addObject:movie];
                }

                if ([self.nowPlayingMovies containsObject:movie] && ![self.filteredNowPlayingMovies containsObject:movie]) {
                    [self.filteredNowPlayingMovies addObject:movie];
                }
            }
        }

    }
    
    [self.tableView reloadData];
}

@end
