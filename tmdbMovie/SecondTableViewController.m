//
//  SecondTableViewController.m
//  tmdbMovie
//
//  Created by Rafay on 11/8/16.
//  Copyright © 2016 AstuteSol. All rights reserved.
//

#import "SecondTableViewController.h"
#import "RootTableViewController.h"
#import "dataApi.h"
#import "ThirdViewController.h"
@interface SecondTableViewController ()



@end

@implementation SecondTableViewController{
    NSMutableData *webData;
    NSMutableArray *array;
    NSMutableArray *arrayId;
    NSURLConnection *connection;
    UITableViewCell *selectedCell;
    NSUInteger lastIndex;

}
@synthesize connectorClass;
- (void)viewDidLoad {
    
    NSNumber *getID=connectorClass.IdBeingPassed;
    NSString *getname=connectorClass.movieNameBeingPassed;
    
    NSString *getPosterPath=connectorClass.posterPathBeingPassed;
    NSString *Baseurl=@"https://image.tmdb.org/t/p/w500";
    NSString *newUrl=[Baseurl stringByAppendingString:getPosterPath];
    NSNumber *getVote=connectorClass.voteBeingPassed;
    NSString *myNumberInString = [getVote stringValue];
    NSString *movieIDinString= [getID stringValue];
       _labelText.text=getname;
   _lblVote.text=myNumberInString;
    _lblDes.text=connectorClass.desBeingPassed;
    _imageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newUrl]]];
    self.navigationController.navigationBar.backItem.title = @"Custom text";
    //------castApi----//
    
    
   
    [super viewDidLoad];
    [[self tableView2]setDelegate:self ];
    [[self tableView2]setDataSource:self];
    array=[[NSMutableArray alloc]init];
    
    NSString *castString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/credits?api_key=c4bd81709e87b12e6c74a08609433c49",movieIDinString];
    NSURL *url=[NSURL URLWithString:castString];

    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    if (connection)
    {
        webData=  [[NSMutableData alloc]init];
    }
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSArray *array1 = [[NSArray alloc]initWithArray:[allData objectForKey:@"cast"]];
    
    
    
    for (NSDictionary *diction in array1)
    {
        
        dataApi *api = [[dataApi alloc]init];
        api.actorName=[diction objectForKey:@"name"];
        api.actorId=[diction objectForKey:@"id"];
        api.charchter=[diction objectForKey:@"character"];
        api.profilePath=[diction objectForKey:@"profile_path"];
        [array addObject:api];
        
    }
    
    [[self tableView2 ]reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    dataApi *current = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [current actorName];
    cell.detailTextLabel.text=[current charchter];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //selectedcelltext
    NSIndexPath *path=[tableView indexPathForSelectedRow];
    
    
    lastIndex = [path indexAtPosition:[path length] - 1];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    dataApi *aBook = [array objectAtIndex:lastIndex];
    actorProfilePath=aBook.profilePath;
    actorID=aBook.actorId;
    [self performSegueWithIdentifier:@"showDetails2" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetails2"]) {
        ThirdViewController *vc=segue.destinationViewController;
        Connector *connectorClass=[[Connector alloc]init];
        connectorClass.posterActorBeingPassed=actorProfilePath;
        connectorClass.actorID=actorID;
        vc.connectorClass=connectorClass;
    }
     
}

@end
