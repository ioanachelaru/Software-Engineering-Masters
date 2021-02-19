/* Subscriber
 * Author: ioana
 * Creation date: 2/15/2021
 */
MACHINE
    Subscriber

USES
    Library
    
SEES
    String

SETS
    SUBSCRIBER

ABSTRACT_VARIABLES
    subscribers,
    subscriberId,
    subscriberName,
    subscriberAge,
    subscriberBooks,
    subscriberLibrary
    
INVARIANT
    subscribers <: SUBSCRIBER &
    subscriberId : subscribers >-> STR &
    subscriberName : subscribers --> STR &
    subscriberAge : subscribers --> NATURAL1 &
    subscriberBooks : subscribers --> NATURAL &
    
    ! subs . (subs : subscribers => subscriberBooks(subs) <=3) &
    
    subscriberLibrary : subscribers --> libraries &
    
    ! subs . (subs : subscribers => subscriberAge(subs) >= 7)

INITIALISATION
    subscribers,
    subscriberId,
    subscriberName,
    subscriberAge,
    subscriberBooks,
    subscriberLibrary := {},{},{},{},{},{}

OPERATIONS
    newSubscriber <-- createSubscriber(nameValue, ageValue, libraryValue)=
    PRE
        nameValue : STR &
        libraryValue : libraries &
        ageValue : NATURAL1 &
        ageValue >= 7 
    THEN
        ANY subs
        WHERE
            subs : SUBSCRIBER - subscribers
        THEN
            subscribers := subscribers \/ {subs} ||
            ANY idValue
            WHERE
                idValue : STR &
                idValue /: ran(subscriberId)
            THEN
                subscriberId(subs) := idValue
            END ||
           subscriberName(subs) := nameValue ||
           subscriberAge(subs) := ageValue ||
           subscriberBooks(subs) := 0 ||
           subscriberLibrary(subs) := libraryValue ||
           
           newSubscriber := subs
       END
   END;
   
   
   setSubscriberName(subscriberValue, nameValue) =
   PRE
       subscriberValue : subscribers &
       nameValue : STR
   THEN
       subscriberName(subscriberValue) := nameValue
   END;
   
   
   setSubscriberAge(subscriberValue, ageValue)=
   PRE
       subscriberValue : subscribers &
       ageValue : NATURAL1 &
       ageValue >= 7
   THEN
       subscriberAge(subscriberValue) := ageValue
   END;
   
   
   setSubscriberLibrary(subscriberValue, libraryValue)=
   PRE
       subscriberValue : subscribers &
       libraryValue : libraries
   THEN
       subscriberLibrary(subscriberValue) := libraryValue
   END;
   
   
   increaseSubscriberBooks(subscriberValue)=
   PRE
       subscriberValue : subscribers
   THEN
       IF subscriberBooks(subscriberValue) < 3 THEN
       subscriberBooks(subscriberValue) := subscriberBooks(subscriberValue) + 1
       END
   END;
   
   
   idValue <-- getSubscriberId(subscriberValue)=
   PRE
       subscriberValue : subscribers
   THEN
       idValue := subscriberId(subscriberValue)
   END;
   
   
   ageValue <-- getSubscriberAge(subscriberValue)=
   PRE
       subscriberValue : subscribers
   THEN
       ageValue := subscriberAge(subscriberValue)
   END;
   
   
   booksValue <-- getSubscriberBooks(subscriberValue)=
   PRE
       subscriberValue : subscribers
   THEN
       booksValue := subscriberBooks(subscriberValue)
   END;
   
   
   libraryValue <-- getSubscriberLibrary(subscriberValue)=
   PRE
       subscriberValue : subscribers
   THEN
       libraryValue := subscriberLibrary(subscriberValue)
   END;
   
   
   newSubscriber <-- modifySubscriber(subscriberValue, nameValue, ageValue)=
   PRE
        subscriberValue : subscribers &
        nameValue: STR &
        ageValue : NATURAL1 &
        ageValue >= 7
           
    THEN
        subscriberName(subscriberValue) := nameValue ||
        subscriberAge(subscriberValue) := ageValue ||
        
        newSubscriber := subscriberValue
    END;
   
   
   destroySubscriber(subscriberValue)=
   PRE
       subscriberValue : subscribers
   THEN
       subscribers := subscribers - {subscriberValue} ||
       subscriberId := {subscriberValue} <<| subscriberId ||
       subscriberName := {subscriberValue} <<| subscriberName ||
       subscriberAge := {subscriberValue} <<| subscriberAge ||
       subscriberBooks := {subscriberValue} <<| subscriberBooks ||
       subscriberLibrary := {subscriberValue} <<| subscriberLibrary
   END;
   
   
   removeAllSubscribersFromLibrary(libraryValue)=
   PRE
       libraryValue : libraries
   THEN
       subscribers := subscribers - subscriberLibrary~[{libraryValue}] ||
       subscriberLibrary := subscriberLibrary |>> {libraryValue} ||
       subscriberId := subscriberLibrary~[{libraryValue}] <<| subscriberId ||
       subscriberName := subscriberLibrary~[{libraryValue}] <<| subscriberName ||
       subscriberBooks := subscriberLibrary~[{libraryValue}] <<| subscriberBooks ||
       subscriberAge := subscriberLibrary~[{libraryValue}] <<| subscriberAge
   END

END
