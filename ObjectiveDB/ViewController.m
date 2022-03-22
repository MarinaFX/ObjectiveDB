//
//  ViewController.m
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 21/03/22.
//

#import "ViewController.h"
#import "model/Movie.h"
#import "model/MovieService.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Movie *movie = [[Movie alloc] initWithId:@1 title:@"flemis" overview:@"flemis overview" rating:@2.2];
    
    Movie *movie2 = [[Movie alloc] initWithId:@2 title:@"flemis 2"];

    NSLog(@"movie 1 description: %@ \n", [movie description]);
    NSLog(@"movie 2 description: %@ \n", [movie2 description]);
    
    MovieService *service = [MovieService alloc];
    NSURL *posterURL = [NSURL URLWithString:@"https://image.tmdb.org/t/p/w154/74xTEgt7R36Fpooo50r9T25onhq.jpg"];
    
    [service performAsyncImageDownloadsWithWithURL:posterURL completionHandler:^(BOOL success, UIImage *image) {
        if (success) {
            self.moviePoster.image = image;
        }
    }];
}

@end
