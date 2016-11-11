//
//  ThirdViewController.m
//  tmdbMovie
//
//  Created by Rafay on 11/9/16.
//  Copyright © 2016 AstuteSol. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController{
    NSMutableData *webData;
    NSMutableArray *array;
    NSMutableArray *arrayId;
    NSURLConnection *connection;
    UITableViewCell *selectedCell;
    NSUInteger lastIndex;
    

}
@synthesize connectorClass;
- (void)viewDidLoad {
     NSString *Baseurl=@"https://image.tmdb.org/t/p/w500";
     NSString *getPosterPath=connectorClass.posterActorBeingPassed;
    
    if (getPosterPath == (id)[NSNull null])
    {
        _imageView2.image=[[UIImage alloc] initWithContentsOfFile:@"noImage.jpg"];
    
    }
    else{
        NSString *newUrl=[Baseurl stringByAppendingString:getPosterPath];
        _imageView2.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newUrl]]];
    }
    NSNumber *getActorID=connectorClass.actorID;
    
    [super viewDidLoad];
    NSString *castString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/person/%@?api_key=c4bd81709e87b12e6c74a08609433c49&language=en-US&append_to_response=undefined",getActorID];
    NSURL *url=[NSURL URLWithString:castString];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    if (connection)
    {
        webData=  [[NSMutableData alloc]init];
    }
    
       // Do any additional setup after loading the view.
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [webData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webData appendData:data];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Fail With Error");
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSDictionary *allData=[NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSString *bio=[allData objectForKey:@"biography"];
    if (bio == (id)[NSNull null])
    {
        _lblBio.text=@"Not Found";
        
    }
    else
    {
       _lblBio.text=bio;
    }
    NSString *birthPlace=[allData objectForKey:@"place_of_birth"];
    if (birthPlace==(id)[NSNull null]) {
        _lblPlaceofBirth.text=@"Not Found";
    }
    else{
        _lblPlaceofBirth.text=birthPlace;
    }
    NSString *DOB=[allData objectForKey:@"birthday"];
    if(DOB==(id)[NSNull  null]){
        _lblBirthday.text=@"Not Found";
    }
    else{
        _lblBirthday.text=DOB;
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
