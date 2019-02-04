/*Not:Excel tablosunundaki verilerin haricinde testleri duzgun gosterebilmek amaciyla kendim de extra veri ekledim ve ekledigim verilerin basina yorum satiri icinde test yazdim*/
/*1.Example Query For Check whether there is any scheduling conflict.*/
/* conflicts(CourseID1,CourseID2).*/ /*Output: CourseID1 = cse888,CourseID2 = cse999.*/

/*2.Example Query For Check which room can be assigned to a given class.*/
/*assign(RoomID,cse343).*/ /*Output:False becasue cse343 has already a room*/
/*assign(RoomID,cse777).*/ /*Output:RoomID = z06 ;RoomID = z06 ; RoomID = z11.*//*these room enough capacity and enough time*/

/*3.Example Query For Check which room can be assigned to which classes.*/
/*assign(RoomID,CourseID).*/ /*Output:RoomID = z06,CourseID = cse777 ;RoomID = z06,CourseID = cse777 ;RoomID = z11,CourseID = cse777.*/

/*4.Example Query For Check whether a student can be enrolled to a given class.*/
/*enroll(4,cse343).*/ /*Output:True because capacity is enough also there is no equipment conflict*/
/*enroll(8,cse666).*/ /*Output:False because room of cse666 is not handicapped but student 8 is handicapped */

/*5.Check which classes a student can be assigned.*/
/*enroll(4,CourseID).*/ /*Output:CourseID = cse343 ; CourseID = cse331 ;CourseID = cse777 ; Becasue only these Courses has enough capacity.*/
/*enroll(8,CourseID).*/ /*Output:CourseID = cse343 ; CourseID = cse331 ; CourseID = cse777 ; Because student 8 is handicapped and these rooms are for handicapped and they have enough capacity.*/

:- dynamic(room/3).     %System should be able to add a new room so it must be dynamic
:- dynamic(course/6).   %System should be able to add a new course so it must be dynamic
:- dynamic(student/3).  %System should be able to add a new student so it must be dynamic

/*ID,Capacity,RoomEquipmentsList*/
room(z06,10,[hcapped,projector]).
room(z11,10,[hcapped,smartboard]).


/*test*/room(z66,10,[]). /*For Making True The Enroll Test*/


/*ID,Instructor,Capacity,Hour,Room,CourseNeedsList*/
course(cse341,genc    ,10,4,z06,[]). 
course(cse343,turker  ,6 ,3,z11,[]). 
course(cse331,bayrakci,5 ,3,z06,[]).
course(cse321,gozupek ,10,4,z11,[]).

/*test*/course(cse888,burhan ,10,4,z11,[]).  /*For Making True The Conflict Test*/
/*test*/course(cse999,elgun ,10,4,z11,[]).   /*For Making True The Conflict Test*/

/*test*/course(cse777,mehmet ,10,1,none,[]).   /*For Making True The Assign Test*/

/*test*/course(cse666,ahmet ,10,1,z66,[]).   /*For Making True The Enroll Test*/

/*Room,Hour,Course,RemainingHourForFinish*/
occupancy(z06,8 ,cse341,4). 
occupancy(z06,9 ,cse341,3).
occupancy(z06,10,cse341,2).
occupancy(z06,11,cse341,1).
occupancy(z06,12,none  ,1).
occupancy(z06,13,cse331,3).
occupancy(z06,14,cse331,2).
occupancy(z06,15,cse331,1).
occupancy(z06,16,none  ,1).

occupancy(z11,8 ,cse343,4).
occupancy(z11,9 ,cse343,3).
occupancy(z11,10,cse343,2).
occupancy(z11,11,cse343,1).
occupancy(z11,12,none  ,2).
occupancy(z11,13,none  ,1).
occupancy(z11,14,cse321,3).
occupancy(z11,15,cse321,2).
occupancy(z11,16,cse321,1).


/*test*/occupancy(z11,17 ,cse888,4).   /*For Making True The Conflict Test*/
/*test*/occupancy(z11,17 ,cse999,4).   /*For Making True The Conflict Test*/


/*SID,CourseList,isHcapped*/
student(1 ,[cse331,cse341,cse343],no). 
student(2 ,[cse341,cse343]       ,no).
student(3 ,[cse331,cse341]       ,no).
student(4 ,[cse341]              ,no).
student(5 ,[cse331,cse343]       ,no).
student(6 ,[cse331,cse341,cse343],yes).
student(7 ,[cse341,cse343]       ,no).
student(8 ,[cse331,cse341]       ,yes).
student(9 ,[cse341]              ,no).
student(10,[cse321,cse341]       ,no).
student(11,[cse321,cse341]       ,no).
student(12,[cse321,cse343]       ,no).
student(13,[cse321,cse343]       ,no).
student(14,[cse321,cse343]       ,no).
student(15,[cse321,cse343]       ,yes).


/*ID,Course,InstructorNeedsList*/
instructor(genc    ,cse341,[projector]). 
instructor(turker  ,cse343,[smartboard]). 
instructor(bayrakci,cse331,[]).
instructor(gozupek ,cse321,[smartboard]).

/*test*/instructor(burhan ,cse888,[]).  /*For Making True The Conflict Test*/
/*test*/instructor(elgun ,cse999,[]).   /*For Making True The Conflict Test*/

/*test*/instructor(mehmet ,cse777,[]).  /*For Making True The Assign Test*/

/*test*/instructor(ahmet ,cse666,[]).  /*For Making True The Enroll Test*/



/*adding room to the system*/
addRoom(Id,Capacity,L):-
    Fact =.. [room,Id,Capacity,L],
    assertz(Fact).


/*adding course to the system*/
addCourse(Id,Instructor,Capacity,Hour,Room,L):-
    Fact =.. [course,Id,Instructor,Capacity,Hour,Room,L],
    assertz(Fact).


/*adding student to the system*/
addStudent(SID,L,IsHcapped):-
    Fact =.. [student,SID,L,IsHcapped],
    assertz(Fact).


/*Checking whether there is any scheduling conflict*/
conflicts(CourseID1,CourseID2):- 
    course(CourseID1,_,_,_,CourseRoom,_),          /*Getting CourseRoom of CourseID1 and it must be same with CourseID2's for being conflict*/
    course(CourseID2,_,_,_,CourseRoom,_),          /*Getting CourseRoom of CourseID2 and it must be same with CourseID1's for being conflict*/
    occupancy(CourseRoom,CourseHour,CourseID1,_),  /*If CourseRoom Hour for CourseID1 and CourseID2 is same and*/
    occupancy(CourseRoom,CourseHour,CourseID2,_),   
    CourseID1 \= CourseID2,!                        /*if CourseID1 is not equal to CourseID2 then there will be a conflict*/
    ;                                                     /*OR*/
    course(CourseID1,Inst1,_,_,CourseRoom,_),    /*if two course is in same room and Instructors are different*/
    course(CourseID2,Inst2,_,_,CourseRoom,_),   
    occupancy(CourseRoom,CourseHour,CourseID1,_),  /*if the courses are in same hour*/
    occupancy(CourseRoom,CourseHour,CourseID2,_),    
    Inst1 \= Inst2,CourseID1 == CourseID2,!.  /*also if courses are same then there will be conflict*/
    

/*Check which room can be assigned to a given class and Check which room can be assigned to which classes.*/
assign(RoomID,CourseID):-
    course(CourseID,Instructor,CourseCapacity,RemainingHour,none,CourseNeedsList),  /*getting infos of course*/
    instructor(Instructor,CourseID,InstructorNeedsList),   /*getting infos of instructor of the course*/
    occupancy(RoomID,_,none,RemainingHour),          /*if there is a room which equal with room RemainingHour and course hour*/                                                   
    room(RoomID,RoomCapacity,RoomEquipmentsList),     /*getting RoomCapacity and RoomEquipmentsList*/
    InstructorNeedsList\=[],                       /*if instructor needs is not empty*/
    CourseNeedsList\=[],                            /*if course needs is not empty*/
    isSublist(CourseNeedsList, RoomEquipmentsList),  /*check RoomEquipmentsList contains all CourseNeedsList elements*/
    isSublist(InstructorNeedsList, RoomEquipmentsList),  /*check RoomEquipmentsList contains all InstructorNeedsList elements*/
    controlAssignForHandicappedStudent(RoomID,CourseID),  /*if there is a special needs student in the course room must be hcapped */
    CourseCapacity=<RoomCapacity;          /*for assignment room capacity must be bigger or equal to course capacity*/           

    course(CourseID,Instructor,CourseCapacity,RemainingHour,none,CourseNeedsList), 
    instructor(Instructor,CourseID,InstructorNeedsList),   
    occupancy(RoomID,_,none,RemainingHour),                                                             
    room(RoomID,RoomCapacity,RoomEquipmentsList),   
    InstructorNeedsList\=[],          /*if instructor needs is not empty*/         
    CourseNeedsList==[],               /*if course needs is empty*/       
    isSublist(InstructorNeedsList, RoomEquipmentsList),   /*check RoomEquipmentsList contains all InstructorNeedsList elements*/
    controlAssignForHandicappedStudent(RoomID,CourseID),  
    CourseCapacity=<RoomCapacity;   

    course(CourseID,Instructor,CourseCapacity,RemainingHour,none,CourseNeedsList),  
    instructor(Instructor,CourseID,InstructorNeedsList),   
    occupancy(RoomID,_,none,RemainingHour),                                                              
    room(RoomID,RoomCapacity,RoomEquipmentsList),   
    InstructorNeedsList==[],  /*if instructor needs is empty*/ 
    CourseNeedsList\=[],    /*if course needs is not empty*/
    isSublist(CourseNeedsList, RoomEquipmentsList),  /*check RoomEquipmentsList contains all CourseNeedsList elements*/
    controlAssignForHandicappedStudent(RoomID,CourseID),  
    CourseCapacity=<RoomCapacity;   

    course(CourseID,Instructor,CourseCapacity,RemainingHour,none,CourseNeedsList),  
    instructor(Instructor,CourseID,InstructorNeedsList),   
    occupancy(RoomID,_,none,RemainingHour),  
    InstructorNeedsList==[],                /*if instructor needs is empty*/  /*there is no need to checking for the needs*/
    CourseNeedsList==[],                    /*if course needs is empty*/                    
    room(RoomID,RoomCapacity,_RoomEquipmentsList),   
    controlAssignForHandicappedStudent(RoomID,CourseID),  
    CourseCapacity=<RoomCapacity.   


/*true is course has hcapped student else false*/
isCourseContainsHandicappedStudent(CourseID):-
    student(_X,CourseList,yes),  
    member(CourseID,CourseList).  


/*true if course has a hcapped student and room has hcapped else false*/
controlAssignForHandicappedStudent(RoomID,CourseID):-   /*if then else structure*/
    (  isCourseContainsHandicappedStudent(CourseID)  
    -> room(RoomID,_,RoomEquipmentsList),    
    member(hcapped,RoomEquipmentsList)   
    ; true   
     ).


/*true if L1 is sublist of L2, else false*/
isSublist(L1, L2) :- 
    maplist(contains(L2), L1).


/*true if L contains X */
contains(L, X) :- 
    member(X, L).


/*Check whether a student can be enrolled to a given class and Check which classes a student can be assigned.*/
enroll(StudentID,CourseID):-
    student(StudentID,_TakenCourseList,yes), /*if student is hcapped*/
    course(CourseID,_CourseInstructor,CourseCapacity,_CourseHour,CourseRoom,_CourseNeedList), /*getting CourseRoom info of CourseID*/
    room(CourseRoom,RoomCapacity,RoomEquipmentsList), /*Geting CourseRoom Capacity and RoomEquipmentsList of CourseRoom*/
    member(hcapped,RoomEquipmentsList),  /*if Room is hcapped and*/
    CourseCapacity+1=<RoomCapacity  /*if CourseCapacity+1 less than or equal from RoomCapacity the student can be enroll the Course*/
    ;   /*OR*/
    student(StudentID,_TakenCourseList,yes), /*if student is hcapped*/
    course(CourseID,_CourseInstructor,_CourseCapacity,_CourseHour,none,_CourseNeedList) /*if course is not assigned a room then there is no need to check the hcapped situation*/
    ;  /*OR*/
    student(StudentID,_TakenCourseList,no), /*if student is not hcapped we don't need to control whether the room is hcapped*/
    course(CourseID,_CourseInstructor,CourseCapacity,_CourseHour,CourseRoom,_CourseNeedList),  /*getting CourseRoom info of CourseID*/
    room(CourseRoom,RoomCapacity,_RoomEquipmentsList),  /*Geting CourseRoom Capacity and RoomEquipmentsList of CourseRoom*/
    CourseCapacity+1=<RoomCapacity;  /*if CourseCapacity+1 less than or equal from RoomCapacity the student can be enroll the Course*/

    student(StudentID,_TakenCourseList,no), /*if student is not hcapped*/
    course(CourseID,_CourseInstructor,_CourseCapacity,_CourseHour,none,_CourseNeedList). /*if course is not assigned a room then there is no need to check the hcapped situation*/