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
Fetch a movie poster from the TMDB.
 
@param URL The movie poster URL
@param completionBlock The completion block
 
*/
-(void) performAsyncImageDownloadsWithURL: (NSString*)URL completionHandler: (FetchPostercompletionBlock)completionBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *formatURL = [NSString stringWithFormat:@"%@", URL];
        NSURL *imagePosterURL = [NSURL URLWithString:formatURL];
        NSData *imageData = [NSData dataWithContentsOfURL:imagePosterURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                completionBlock(YES, image);
            }
            else {
                completionBlock(NO, nil);
            };
        });
    });
}

@end
