/* knowledge base*/
flight(edirne,erzurum,5).
flight(erzurum,edirne,5).

flight(erzurum,antalya,2).
flight(antalya,erzurum,2).

flight(antalya,izmir,1).
flight(izmir,antalya,1).

flight(izmir,istanbul,3).
flight(istanbul,izmir,3).

flight(izmir,ankara,6).
flight(ankara,izmir,6).

flight(istanbul,ankara,2).
flight(ankara,istanbul,2).

flight(ankara,trabzon,6).
flight(trabzon,ankara,6).

flight(ankara,kars,3).
flight(kars,ankara,3).

flight(kars,gaziantep,3).
flight(gaziantep,kars,3).

flight(antalya,diyarbakir,5).
flight(diyarbakir,antalya,5).

flight(diyarbakir,ankara,8).
flight(ankara,diyarbakir,8).

flight(istanbul,trabzon,3).
flight(trabzon,istanbul,3).

/* rules*/

route(X , Y , C) :- connectedCities(X , Y , C , []).     %last parameter is a list which is using for storing the visited cities
connectedCities(X , Y , C , List) :-flight(X , Y , C);   %controlling whether there is a direct flight between given X and Y with cost C
(not(member(X , List))),								 %these line means the city X cannot been visited before
flight(X , M , P),                  				     %check there is a direct route between source X and destination M with cost C 
connectedCities(M , Y , B , [X|List]),                   %if above queries works then call the recursively with source M , destination M, cost B(if it works we add the B to the total cost ), also we add the X to the visited cities list with [X|List] 
X\=Y,                                                    %there is not let to flight in same city, cities has to be different
C is P + B.                                              %added weights to the total cost between the connected cities


