//
//  ViewController.m
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 21/03/22.
//

#import "ViewController.h"
#import "model/Movie.h"
#import "model/MovieService.h"
#import "Views/MovieTableCell.h"
#import "MovieDetailViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *movies;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    Movie *movie1 = [[Movie alloc] initWithId:@1 title:@"Yondaime Hokage" overview:@"Senpō: Rasengan!" rating:@9.5];
    [movie1 setImageCover:[UIImage imageNamed:@"default"]];
    
    Movie *movie2 = [[Movie alloc] initWithId:@2 title:@"Nanadaime Hokage" overview:@"Fūton: Rasenshuriken!" rating:@10.0];
    [movie2 setImageCover:[UIImage imageNamed:@"default3"]];
    
    Movie *movie3 = [[Movie alloc] initWithId:@3 title:@"Shodaime Hokage" overview:@"Mokuton: Jokai Kotan" rating:@8.9];
    [movie3 setImageCover:[UIImage imageNamed:@"default2"]];
    
    Movie *movie4 = [[Movie alloc] initWithId:@4 title:@"Godaime Hokage" overview:@"Kuchiyose no Jutsu" rating:@9.2];
    [movie4 setImageCover:[UIImage imageNamed:@"default4"]];

    
    _movies = @[movie1, movie2, movie3, movie4];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqual: @"toDetails"] && sender != nil) {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        MovieDetailViewController *destination = segue.destinationViewController;
        
        if (indexPath.section == 0) {
            destination.movie = _movies[indexPath.row];
        }
        else {
            destination.movie = _movies[indexPath.row];
        }
    }
}

//MARK: - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toDetails" sender:indexPath];
}

//MARK: - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieTableCell"];
    
    if (cell == nil) {
        cell = (MovieTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MovieTableCell"];        
    }
    
    Movie *currentMovie = [_movies objectAtIndex:indexPath.row];
    
    cell.moviePoster.image = [currentMovie imageCover];
    cell.movieTitleLabel.text = [currentMovie title];
    cell.movieOverviewLabel.text = [currentMovie overview];
    cell.movieRatingLabel.text = [[currentMovie rating] stringValue];
    
    return cell;
}

@end
