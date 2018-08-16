## Predicting stocking requirements for Divvy Bike Stations

Divvy is a Chicago based bike sharing company with 585 stations across the city. Divvy is a great way to get around Chicago, but getting from point A to point B smoothly relies on an available bike at the desired starting point, and an empty slot to dock the bike at the destination. If a customer looks to start their journey, and finds out there aren't any bikes available at the closest station, this will sour their experience as they now have to travel to another station or find another mode of transport. The same is true if a customer plans to end their trip at a particular location and finds there are not any empty slots available to dock their bike. They now have to find another location within their trip time window, and backtrack to their desired destination. 

To help minimize these negative experiences, this analysis takes a look at Divvy's historical trip data to better understand rider usage and predict stocking requirements for Divvy's bike stations.

The historical trip data can be found on Divvy's website (https://www.divvybikes.com/system-data) along with information about their bike stations. Please see the avaialable fields in these datasetsb below:

Trip Data:
trip_id: ID attached to each trip taken
start_time: day and time trip started, in CST
stop_time: day and time trip ended, in CST
bikeid: ID attached to each bike
tripduration: time of trip in seconds 
from_station_name: name of station where trip originated
to_station_name: name of station where trip terminated 
from_station_id: ID of station where trip originated
to_station_id: ID of station where trip terminated
usertype: "Customer" is a rider who purchased a 24-Hour Pass; "Subscriber" is a rider who purchased an Annual Membership
gender: gender of rider 
birthyear: birth year of rider

Station Data:
id: ID attached to each station
name: station name    
latitude: station latitude
longitude: station longitude
dpcapacity: number of total docks at each station as of 12/31/2017
online_date: date the station was created in the system

This analysis focuses on the trip and station data for 2017, and provides stocking recommendations for all of Divvy's stations by day of the week and month of the year. 
