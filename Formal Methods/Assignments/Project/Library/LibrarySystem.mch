MACHINE
    LibrarySystem
SEES
    String

INCLUDES
    Library, Librarian, Subscriber, Book, Borrowing

PROMOTES
    createLibrary, getLibraryName, setLibraryName, modifyLibrary, destroyLibrary, createLibrarian, setLibrarianName, setLibrarianAddress, getLibrarianId, getLibrarianName, getLibrarianAddress, modifyLibrarian, destroyLibrarian, removeAllLibrariansFromLibrary, createSubscriber, setSubscriberName, setSubscriberLibrary, increaseSubscriberBooks, getSubscriberId, getSubscriberAge, getSubscriberBooks, getSubscriberLibrary, modifySubscriber, destroySubscriber, removeAllSubscribersFromLibrary, createBook, setBookTitle, setBookAuthor, setBookYear, setBookRecommendedAge, setBookStatus, getBookId, getBookTitle, getBookAuthor, getBookYear, getBookRecommendedAge, getBookStatus, getAnimalCircus, modifyBook, destroyBook, removeAllBooksFromLibrary, createBorrowing, setBorrowingBook, setBorrowingSubscriber, setBorrowingLibrarian, setBorrowingDate, getBorrowingId, getBorrowingBook, getBorrowingSubscriber, getBorrowingLibrarian, getBorrowingDate, modifyBorrowing, destroyBorrowing, removeAllBorrowingsFromLibrarian, removeAllBorrowingsFromSubscriber, removeAllBorrowingsFromBook

OPERATIONS
    deleteLibrary(libraryValue)=
    PRE
        libraryValue : libraries
    THEN
        
        removeAllLibrariansFromLibrary(libraryValue) ||
        removeAllBooksFromLibrary(libraryValue) ||
        removeAllSubscribersFromLibrary(libraryValue) ||
        
        destroyLibrary(libraryValue)
    END;
    
    
    deleteLibrarian(librarianValue)=
    PRE
        librarianValue : librarians
    THEN
        removeAllBorrowingsFromLibrarian(librarianValue) ||
        destroyLibrarian(librarianValue)
    END;
    
    
    deleteSubscriber(subscriberValue)=
    PRE
        subscriberValue : subscribers
    THEN
        removeAllBorrowingsFromSubscriber(subscriberValue) ||
        destroySubscriber(subscriberValue)
    END;
    
    
    deleteBook(bookValue)=
    PRE
        bookValue : books
    THEN
        removeAllBorrowingsFromBook(bookValue) ||
        destroyBook(bookValue)
    END;
    
    
    makeBorrowing(bookValue, subscriberValue, librarianValue, currentDateValue)=
    PRE
        bookValue : books &
        librarianValue : librarians &
        subscriberValue : subscribers &
        subscriberBooks(subscriberValue) < 3 &
        currentDateValue : STR
    THEN
        increaseSubscriberBooks(subscriberValue) ||
        createBorrowing(bookValue, subscriberValue, librarianValue, currentDateValue) 
        
    END

END
