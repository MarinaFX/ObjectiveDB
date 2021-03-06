//
//  MovieService.m
//  ObjectiveDB
//
//  Created by Marina De Pazzi on 22/03/22.
//

#import <Foundation/Foundation.h>
#import "MovieService.h"

@implementation MovieService

/**
 Fetch all movies from the TMDB.

 @param completionBlock The completion block
 
 */
-(void) performAsyncMoviesDownloadWithType: (NSString*)type completionBlock:
(FetchMoviesCompletionBlock) completionBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //creating formatted URL
        NSString *formatURL = [NSString stringWithFormat: @"https://api.themoviedb.org/3/movie/now_playing?api_key=dd5a68ffc24d87f1b7ff8161056a315f&page=1"];
        if ([type  isEqual: @"popular"]) {
            formatURL = [NSString stringWithFormat: @"https://api.themoviedb.org/3/movie/popular?api_key=dd5a68ffc24d87f1b7ff8161056a315f&page=1"];
        }
        NSURL *moviesURL = [NSURL URLWithString:formatURL];
        
        //storing movies JSON into an array
        NSData *moviesData = [NSData dataWithContentsOfURL: moviesURL];
        NSDictionary *contentDictionary = [NSJSONSerialization JSONObjectWithData: moviesData options: 0 error: NULL];
        NSArray *moviesArrayAsJSON = contentDictionary[@"results"];
        
        //creating and filling the array to return the movies
        NSMutableArray *movies = [[NSMutableArray alloc] init];
        for (NSDictionary *movie in moviesArrayAsJSON) {
            Movie *movieObject = [[Movie alloc] init];
            movieObject.ID = movie[@"id"];
            movieObject.title = movie[@"title"];
            movieObject.overview = movie[@"overview"];
            movieObject.rating = movie[@"vote_average"];
            movieObject.posterPath = movie[@"poster_path"];
            [movies addObject: movieObject];
        }
        
        //returning the movies
        if (contentDictionary == nil || moviesData == nil || movies.count == 0) {
            completionBlock(NO, movies);
        }
        else {
            completionBlock(YES, movies);
        }
    });
}

/**
 Fetch a movie poster from the TMDB.
 
 @param URL The movie poster NSString URL
 @param completionBlock The completion block
 
 */
-(void) performAsyncImageDownloadWithURL: (NSString *)URL completionBlock: (FetchPosterCompletionBlock)completionBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *formatURL = [NSString stringWithFormat:@"%@", URL];
        NSURL *imagePosterURL = [NSURL URLWithString:formatURL];
        NSData *imageData = [NSData dataWithContentsOfURL:imagePosterURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        if (image) {
            completionBlock(YES, image);
        }
        else {
            completionBlock(NO, nil);
        };
    });
}

@end
