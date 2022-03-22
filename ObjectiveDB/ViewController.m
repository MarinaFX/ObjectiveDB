//
//  ViewController.m
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 21/03/22.
//

#import "ViewController.h"
#import "model/Movie.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Movie *movie = [[Movie alloc] initWithId:@1 title:@"flemis" overview:@"flemis overview" rating:@2.2];
    
    Movie *movie2 = [[Movie alloc] initWithId:@2 title:@"flemis 2"];
    
    NSLog(@"movie 1 description: %@ \n", [movie description]);
    NSLog(@"movie 2 description: %@ \n", [movie2 description]);
    
}


@end
