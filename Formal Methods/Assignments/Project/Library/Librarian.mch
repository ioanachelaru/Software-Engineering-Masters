/* Librarian
 * Author: ioana
 * Creation date: 2/15/2021
 */
MACHINE
    Librarian
    
USES
    Library

SEES
    String
    
SETS
    LIBRARIAN
    
ABSTRACT_VARIABLES
    librarians,
    librarianId,
    librarianName,
    librarianAddress,
    librarianLibrary
    
INVARIANT
    librarians <: LIBRARIAN &
    librarianId : librarians >-> STR &
    librarianName : librarians --> STR &
    librarianAddress : librarians --> STR &
    librarianLibrary : librarians --> libraries
    
INITIALISATION
    librarians,
    librarianId,
    librarianName,
    librarianAddress,
    librarianLibrary := {},{},{},{},{}
    
OPERATIONS
    newLibrarian <-- createLibrarian(nameValue, addressValue, libraryValue)=
    PRE
        nameValue : STR &
        addressValue : STR &
        libraryValue : libraries
    THEN
        ANY libr
        WHERE
            libr : LIBRARIAN - librarians
        THEN
            librarians := librarians \/ {libr} ||
            ANY idValue
            WHERE
                idValue : STR &
                idValue /: ran(librarianId)
            THEN
                librarianId(libr) := idValue
            END ||
           librarianName(libr) := nameValue ||
           librarianAddress(libr) := addressValue ||
           librarianLibrary(libr) := libraryValue ||
           
           newLibrarian := libr
       END
   END;
   
   
   setLibrarianName(librarianValue, nameValue) =
   PRE
       librarianValue : librarians &
       nameValue : STR
   THEN
       librarianName(librarianValue) := nameValue
   END;
   
   
   setLibrarianAddress(librarianValue, addressValue)=
   PRE
       librarianValue : librarians &
       addressValue : STR
   THEN
       librarianAddress(librarianValue) := addressValue
   END;
   
   
   idValue <-- getLibrarianId(librarianValue)=
   PRE
       librarianValue : librarians
   THEN
       idValue := librarianId(librarianValue)
   END;
   
   
   nameValue <-- getLibrarianName(librarianValue)=
   PRE
       librarianValue : librarians
   THEN
       nameValue := librarianName(librarianValue)
   END;
   
   
   addressValue <-- getLibrarianAddress(librarianValue)=
   PRE
       librarianValue : librarians
   THEN
       addressValue := librarianAddress(librarianValue)
   END;
   
   
   newLibrarian <-- modifyLibrarian(librarianValue, nameValue, addressValue)=
   PRE
        librarianValue : librarians &
        nameValue: STR &
        addressValue : STR 
    THEN
        librarianName(librarianValue) := nameValue ||
        librarianAddress(librarianValue) := addressValue ||
        
        newLibrarian := librarianValue
    END;
   
   
   destroyLibrarian(librarianValue)=
   PRE
       librarianValue : librarians
   THEN
       librarians := librarians - {librarianValue} ||
       librarianId := {librarianValue} <<| librarianId ||
       librarianName := {librarianValue} <<| librarianName ||
       librarianAddress := {librarianValue} <<| librarianAddress ||
       librarianLibrary := {librarianValue} <<| librarianLibrary    
   END;
   
   
   removeAllLibrariansFromLibrary(libraryValue)=
   PRE
       libraryValue : libraries
   THEN
       librarians := librarians - librarianLibrary~[{libraryValue}] ||
       librarianLibrary := librarianLibrary |>> {libraryValue} ||
       librarianId := librarianLibrary~[{libraryValue}] <<| librarianId ||
       librarianName := librarianLibrary~[{libraryValue}] <<| librarianName ||
       librarianAddress := librarianLibrary~[{libraryValue}] <<| librarianAddress 
   END
    
END
