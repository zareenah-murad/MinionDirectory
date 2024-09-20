//
//  ImageModel.m
//  MinionDirectory
//
//  Created by Zareenah Murad on 9/18/24.
//


#import "ImageModel.h"

@interface ImageModel ()

@property (strong, nonatomic) NSArray* imageNames;

@property (strong, nonatomic) NSDictionary* imagesDict;

@end

@implementation ImageModel

@synthesize imageNames = _imageNames;
@synthesize imagesDict = _imagesDict;


+(ImageModel*)sharedInstance{
    static ImageModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[ImageModel alloc] init];
    } );
    return _sharedInstance;
}

-(NSArray*) imageNames{
    if(!_imageNames)
        _imageNames = @[@"Bob",@"Carl",@"Dave",@"Kevin",@"Stuart"];
    
    return _imageNames;
}


-(UIImage*)getImageWithName:(NSString*)name{
    return self.imagesDict[name];
//    UIImage* image = nil;
//
//    image = [UIImage imageNamed:name];
//
//    return image;
}

// custom getter
// imagesDict is a NSDictionary that stores the name and UIImage
-(NSDictionary*) imagesDict{
    if(!_imagesDict) {
        _imagesDict = @{
            @"Bob": [UIImage imageNamed:@"Bob"],
            @"Carl": [UIImage imageNamed:@"Carl"],
            @"Dave": [UIImage imageNamed:@"Dave"],
            @"Kevin": [UIImage imageNamed:@"Kevin"],
            @"Stuart": [UIImage imageNamed:@"Stuart"]
        };
        
    }
    return _imagesDict;
}

// instance method, return a UIImage ref
-(UIImage*)getImageWithIndex:(NSInteger)index {
    // get all keys (image names) from imagesDict into an array
    NSArray *keys = [self.imagesDict allKeys];
    // get the key at the given index
    NSString *keyAtIndex = [keys objectAtIndex:index];
    // return the image from the dictionary at said index
    return [self.imagesDict objectForKey:keyAtIndex];
}

// instance method, returns # of images in imagesDict
-(NSInteger)numberOfImages {
    // counts the # of key-value pairs in imagesDict
    NSInteger count = [self.imagesDict count];
    return count;
}

// instance method, returns the name (NSString) of an image at a given index
-(NSString*)getImageNameForIndex:(NSInteger)index {
    // get all keys (image names) from imagesDict into an array
    NSArray *keys = [self.imagesDict allKeys];
    // return the key at given index
    return [keys objectAtIndex:index];
}



@end
