/*
Problem: 
     Repairing electronics and donating them
    The P signals to UBB-RC when he has any broken electronics. 
   
 
Actors: 
    Professor (P)
    UBB-Recycle-Center (UBB-RC)
 
Signals: 
   UBB-RC to P (doYouHaveBrokenElectronics?) and P to UBB-RC (haveBrokenElectronics, notYet)
  
*/
 
mtype = {doYouHaveBrokenElectronics, haveBrokenElectronics, notYet}
chan signal = [0] of {mtype};

byte secondsCount=0;
bool electronics_delivered = false;
bool question_asked = false;

active proctype P() {
  	waiting : atomic {
				signal?doYouHaveBrokenElectronics -> {
					printf("P got the question \n");
					secondsCount = 0;
					goto gathering;

				};
		};

	gathering: atomic {		
		if 
		:: secondsCount < 3 -> atomic{
							secondsCount++;										
							goto gathering;
							}

	       	 :: secondsCount == 3 -> atomic {
							signal!haveBrokenElectronics; 
							goto finished;
							}

	       	 :: secondsCount == 3 -> atomic {
							signal!notYet; 
							goto waiting;
							}		
		fi;
	};

	finished: {
		electronics_delivered = true;
	};
}

active proctype UBBRC() {
  	waiting : atomic {
		printf("Do you have broken electronics?\n");
		signal!doYouHaveBrokenElectronics;
		
		question_asked = true;
		goto waitingAnswer;
		};

	waitingAnswer: 
		if
		:: signal?haveBrokenElectronics -> atomic {
								printf("Received broken electronics \n");
								goto finished;
		   					  }
;
		:: signal?notYet -> atomic {
							printf("Not yet, must ask again \n");
							goto waiting;
						};            
		fi;

	finished: atomic { electronics_delivered = true;};
		
}

/* [](!haveBroken -> <> haveBroken) - always, if there are no broken electronics, eventually there will be */

/* [](question_asked -> <> electronics_delivered) - always, when the question is asked, the electronics will be delivered */

/* [](secondsCount < 3 -> [] (!electronics_delivered)) - always, the electronics will be delivered only after minimum 3 seconds have passed */
