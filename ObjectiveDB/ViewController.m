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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView setDataSource:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieTableCell"];
    
    if (cell == nil) {
        cell = (MovieTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MovieTableCell"];
    }
    
    cell.moviePoster.image = [UIImage imageNamed:@"default"];
    cell.movieTitleLabel.text = @"Flemis title";
    cell.movieOverviewLabel.text = @"Flemis overview";
    cell.movieRatingLabel.text = @"2.2";
    
    return cell;
}

@end
