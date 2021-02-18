/* Book
 * Author: ioana
 * Creation date: 2/15/2021
 */
MACHINE
    Book

USES
    Library
    
SEES
    String
    
SETS
    BOOK; STATUS = {available, unavailable}
    
ABSTRACT_VARIABLES
    books,
    bookId,
    bookTitle,
    bookAuthor,
    bookYear,
    bookRecommendedAge,
    bookStatus,
    bookLibrary
    
INVARIANT
    books <: BOOK &
    bookId : books >-> STR &
    bookTitle : books --> STR &
    bookAuthor : books --> STR &
    bookYear : books --> NATURAL1 &
    bookRecommendedAge : books --> NATURAL1 &
    bookStatus : books --> STATUS &
    bookLibrary : books --> libraries

INITIALISATION
    books,
    bookId,
    bookTitle,
    bookAuthor,
    bookYear,
    bookRecommendedAge,
    bookStatus,
    bookLibrary := {},{},{},{},{},{},{},{}

OPERATIONS
    newBook <-- createBook(titleValue, authorValue, yearValue, recommendedAgeValue, statusValue, libraryValue)=
    PRE
        titleValue : STR &
        authorValue : STR &
        yearValue : NATURAL1 &
        recommendedAgeValue : NATURAL1 &
        statusValue : STATUS &
        libraryValue : libraries
    THEN
        ANY bk
        WHERE
            bk : BOOK - books
        THEN
            books := books \/ {bk} ||
            ANY idValue
            WHERE
                idValue : STR &
                idValue /: ran(bookId)
            THEN
                bookId(bk) := idValue
            END ||
            bookAuthor(bk) := authorValue ||
            bookTitle(bk) := titleValue ||
            bookYear(bk) := yearValue ||
            bookRecommendedAge(bk) := recommendedAgeValue ||
            bookStatus(bk) := statusValue ||
            bookLibrary(bk) := libraryValue ||
            
            newBook := bk
        END
    END;
    
    
    setBookTitle(bookValue, titleValue)=
    PRE
        bookValue : books &
        titleValue : STR
    THEN
        bookTitle(bookValue) := titleValue
    END;
    
    
    setBookAuthor(bookValue, authorValue)=
    PRE
        bookValue : books &
        authorValue : STR
    THEN
        bookAuthor(bookValue) := authorValue
    END;
    
    
    setBookYear(bookValue, yearValue)=
    PRE
        bookValue : books &
        yearValue : NATURAL1
    THEN
        bookYear(bookValue) := yearValue
    END;
    
    
    setBookRecommendedAge(bookValue, recAgeValue)=
    PRE
        bookValue : books &
        recAgeValue : NATURAL1
    THEN
        bookRecommendedAge(bookValue) := recAgeValue
    END;
    
    
    setBookStatus(bookValue, statusValue)=
    PRE
        bookValue : books &
        statusValue : STATUS
    THEN
        bookStatus(bookValue) := statusValue
    END;
    
    
    idValue <-- getBookId(bookValue)=
    PRE
        bookValue : books
    THEN
        idValue := bookId(bookValue)
    END;
    
    
    titleValue <-- getBookTitle(bookValue)=
    PRE
        bookValue : books
    THEN
        titleValue := bookTitle(bookValue)
    END;
    
    
    authorValue <-- getBookAuthor(bookValue)=
    PRE
        bookValue : books
    THEN
        authorValue := bookAuthor(bookValue)
    END;
    
    
    yearValue <-- getBookYear(bookValue)=
    PRE
        bookValue : books
    THEN
        yearValue := bookYear(bookValue)
    END;
    
    
    recommendedAgeValue <-- getBookRecommendedAge(bookValue)=
    PRE
        bookValue : books
    THEN
        recommendedAgeValue := bookRecommendedAge(bookValue)
    END;
    
    
    statusValue <-- getBookStatus(bookValue)=
    PRE
        bookValue : books
    THEN
        statusValue := bookStatus(bookValue)
    END;
    
    
    libraryValue <-- getAnimalCircus(bookValue)=
    PRE
        bookValue : books
    THEN
        libraryValue := bookLibrary(bookValue)
    END;
    
    
   newBook <-- modifyBook(bookValue, titleValue, authorValue, yearValue, recAgeValue, statusValue)=
   PRE
        bookValue : books &
        titleValue: STR &
        authorValue: STR &
        yearValue : NATURAL1 &
        recAgeValue : NATURAL1 &
        statusValue : STATUS
           
    THEN
        bookAuthor(bookValue) := authorValue ||
        bookTitle(bookValue) := titleValue ||
        bookYear(bookValue) := yearValue ||
        bookRecommendedAge(bookValue) := recAgeValue ||
        bookStatus(bookValue) := statusValue ||
        
        newBook := bookValue
    END;
    
    
    destroyBook(bookValue) =
    PRE
        bookValue : books
    THEN
        books := books - {bookValue} ||
        bookId := {bookValue} <<| bookId ||
        bookAuthor := {bookValue} <<| bookAuthor ||
        bookTitle := {bookValue} <<| bookTitle ||
        bookYear := {bookValue} <<| bookYear ||
        bookRecommendedAge := {bookValue} <<| bookRecommendedAge ||
        bookStatus := {bookValue} <<| bookStatus ||
        bookLibrary := {bookValue} <<| bookLibrary 
    END;
    
    
    removeAllBooksFromLibrary(libraryValue)=
    PRE
        libraryValue : libraries
    THEN
        books := books - bookLibrary~[{libraryValue}] ||
        bookLibrary := bookLibrary |>> {libraryValue} ||
        bookId := bookLibrary~[{libraryValue}] <<| bookId ||
        bookTitle := bookLibrary~[{libraryValue}] <<| bookTitle ||
        bookAuthor := bookLibrary~[{libraryValue}] <<| bookAuthor ||
        bookYear := bookLibrary~[{libraryValue}] <<| bookYear ||
        bookRecommendedAge := bookLibrary~[{libraryValue}] <<| bookRecommendedAge ||
        bookStatus := bookLibrary~[{libraryValue}] <<| bookStatus
    END
END
