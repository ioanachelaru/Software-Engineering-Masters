/* Borrowing
 * Author: ioana
 * Creation date: 2/15/2021
 */
MACHINE
    Borrowing
   
SEES
    String
    
USES
    Librarian, Book, Subscriber
    
SETS
    BORROWING
    
ABSTRACT_VARIABLES
    borrowings,
    borrowingId,
    borrowingBook,
    borrowingSubscriber,
    borrowingLibrarian,
    borrowingDate
    
INVARIANT
    borrowings <: BORROWING &
    borrowingId : borrowings --> STR &
    borrowingBook : borrowings --> books &
    borrowingLibrarian : borrowings --> librarians &
    borrowingSubscriber : borrowings --> subscribers &
    borrowingDate : borrowings --> STR &
    ! brr . (brr : borrowings => subscriberBooks(borrowingSubscriber(brr)) <= 3 & subscriberBooks(borrowingSubscriber(brr)) >= 0)
    
INITIALISATION
    borrowings,
    borrowingId,
    borrowingBook,
    borrowingSubscriber,
    borrowingLibrarian,
    borrowingDate := {},{},{},{},{},{}

OPERATIONS
    createBorrowing(bookValue, subscriberValue, librarianValue, dateValue)=
    PRE
        bookValue : books &
        subscriberValue : subscribers &
        librarianValue : librarians &
        dateValue : STR &
        subscriberBooks(subscriberValue) : NATURAL &
        subscriberBooks(subscriberValue) < 3 
    THEN
        ANY br
        WHERE
            br : BORROWING - borrowings
        THEN
            borrowings := borrowings \/ {br} ||
            ANY idValue
            WHERE
                idValue : STR &
                idValue /: ran(borrowingId)
            THEN
                borrowingId(br) := idValue
            END ||
            borrowingBook(br) := bookValue ||
            borrowingSubscriber(br) := subscriberValue ||
            borrowingLibrarian(br) := librarianValue ||
            borrowingDate(br) := dateValue 
        END
    END;
    
    
    setBorrowingBook(borrowingValue, bookValue)=
    PRE
        borrowingValue : borrowings &
        bookValue : books
    THEN
        borrowingBook(borrowingValue) := bookValue
    END;
    
    
    setBorrowingSubscriber(borrowingValue, subscriberValue)=
    PRE
        borrowingValue : borrowings &
        subscriberValue : subscribers &
        subscriberBooks(subscriberValue) : NATURAL &
        subscriberBooks(subscriberValue) < 3 
    THEN
        borrowingSubscriber(borrowingValue) := subscriberValue
    END;
    
    
    setBorrowingLibrarian(borrowingValue, librarianValue)=
    PRE
        borrowingValue : borrowings &
        librarianValue : librarians
    THEN
        borrowingLibrarian(borrowingValue) := librarianValue
    END;
    
    
    setBorrowingDate(borrowingValue, dateValue)=
    PRE
        borrowingValue : borrowings &
        dateValue : STR
    THEN
        borrowingDate(borrowingValue) := dateValue
    END;
       
    
    idValue <-- getBorrowingId(borrowingValue)=
    PRE
        borrowingValue : borrowings
    THEN
        idValue := borrowingId(borrowingValue)
    END;
    
    
    bookValue <-- getBorrowingBook(borrowingValue)=
    PRE
        borrowingValue : borrowings
    THEN
        bookValue := borrowingBook(borrowingValue)
    END;
    
    
    subscriberValue <-- getBorrowingSubscriber(borrowingValue)=
    PRE
        borrowingValue : borrowings
    THEN
        subscriberValue := borrowingSubscriber(borrowingValue)
    END;
    
    
    librarianValue <-- getBorrowingLibrarian(borrowingValue)=
    PRE
        borrowingValue : borrowings
    THEN
        librarianValue := borrowingLibrarian(borrowingValue)
    END;
    
    
    dateValue <-- getBorrowingDate(borrowingValue)=
    PRE
        borrowingValue : borrowings
    THEN
        dateValue := borrowingDate(borrowingValue)
    END;
    
    
   newBorrowing <-- modifyBorrowing(borrowingValue, bookValue, subscriberValue, librarianValue, dateValue)=
   PRE
        borrowingValue : borrowings &
        bookValue : books &
        subscriberValue : subscribers &
        librarianValue : librarians &
        dateValue : STR &
        subscriberBooks(subscriberValue) : NATURAL &
        subscriberBooks(subscriberValue) < 3 
           
    THEN
        borrowingBook(borrowingValue) := bookValue ||
        borrowingSubscriber(borrowingValue) := subscriberValue ||
        borrowingLibrarian(borrowingValue) := librarianValue ||
        borrowingDate(borrowingValue) := dateValue ||
        
        newBorrowing := borrowingValue
    END;
    
    
    oldBorrowing <-- destroyBorrowing(borrowingValue) =
    PRE
        borrowingValue : borrowings
    THEN
        borrowings := borrowings - {borrowingValue} ||
        borrowingId := {borrowingValue} <<| borrowingId ||
        borrowingBook := {borrowingValue} <<| borrowingBook ||
        borrowingSubscriber := {borrowingValue} <<| borrowingSubscriber ||
        borrowingLibrarian := {borrowingValue} <<| borrowingLibrarian ||
        borrowingDate := {borrowingValue} <<| borrowingDate ||
        
        oldBorrowing := borrowingValue
    END;
    
    
    removeAllBorrowingsFromLibrarian(librarianValue)=
    PRE
        librarianValue : librarians
    THEN
        borrowings := borrowings - borrowingLibrarian~[{librarianValue}] ||
        borrowingLibrarian := borrowingLibrarian |>> {librarianValue} ||
        borrowingId := borrowingLibrarian~[{librarianValue}] <<| borrowingId ||
        borrowingSubscriber := borrowingLibrarian~[{librarianValue}] <<| borrowingSubscriber ||
        borrowingBook := borrowingLibrarian~[{librarianValue}] <<| borrowingBook ||
        borrowingDate := borrowingLibrarian~[{librarianValue}] <<| borrowingDate
    END;
    
    
    removeAllBorrowingsFromSubscriber(subscriberValue)=
    PRE
        subscriberValue : subscribers
    THEN
        borrowings := borrowings - borrowingSubscriber~[{subscriberValue}] ||
        borrowingSubscriber := borrowingSubscriber |>> {subscriberValue} ||
        borrowingLibrarian := borrowingSubscriber~[{subscriberValue}] <<| borrowingLibrarian ||
        borrowingId := borrowingSubscriber~[{subscriberValue}] <<| borrowingId ||
        borrowingBook := borrowingSubscriber~[{subscriberValue}] <<| borrowingBook ||
        borrowingDate := borrowingSubscriber~[{subscriberValue}] <<| borrowingDate
    END;
    
    
    removeAllBorrowingsFromBook(bookValue)=
    PRE
        bookValue : books
    THEN
        borrowings := borrowings - borrowingBook~[{bookValue}] ||
        borrowingLibrarian := borrowingBook~[{bookValue}] <<| borrowingLibrarian ||
        borrowingId := borrowingBook~[{bookValue}] <<| borrowingId ||
        borrowingSubscriber := borrowingBook~[{bookValue}] <<| borrowingSubscriber ||
        borrowingBook := borrowingBook |>> {bookValue}||
        borrowingDate := borrowingBook~[{bookValue}] <<| borrowingDate
    END
END
