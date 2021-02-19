/* Library
 * Author: ioana
 * Creation date: 2/15/2021
 */
MACHINE
    Library
SEES
    String
SETS
    LIBRARY

ABSTRACT_VARIABLES
    libraries,
    libraryName,
    libraryAddress
    
INVARIANT
    libraries <: LIBRARY &
    libraryName : libraries >-> STR &
    libraryAddress: libraries >-> STR

INITIALISATION
    libraries, libraryName, libraryAddress := {}, {}, {}
    
OPERATIONS
    newLibrary <-- createLibrary(nameValue, addressValue)=
    PRE
        nameValue : STR &
        addressValue : STR &
        nameValue /: ran(libraryName) &
        addressValue /: ran(libraryAddress)
    THEN
        ANY libr
        WHERE
            libr : LIBRARY - libraries
        THEN
            libraries := libraries \/ {libr} ||
            libraryName(libr) := nameValue ||
            libraryAddress(libr) := addressValue ||
            
            newLibrary := libr
        END
    END;
    
    
    nameValue <-- getLibraryName(libraryValue) =
    PRE
        libraryValue : libraries
    THEN
        nameValue := libraryName(libraryValue)
    END;
    
    
    setLibraryName(libraryValue, nameValue) =
    PRE
        libraryValue : libraries &
        nameValue : STR &
        nameValue /: ran(libraryName)
    THEN
        libraryName(libraryValue) := nameValue
    END;
    
    
    destroyLibrary(libraryValue) =
    PRE
        libraryValue : libraries
    THEN
        libraries := libraries - {libraryValue} ||
        libraryName := {libraryValue} <<| libraryName ||
        libraryAddress := {libraryValue} <<| libraryAddress 
        
       
    END;
    
    
    newLibrary <-- modifyLibrary(libraryValue, nameValue, addressValue) = 
    PRE
        libraryValue : libraries &
        nameValue: STR &
        addressValue : STR &
        nameValue /: ran(libraryName) &
        addressValue /: ran(libraryAddress)
    THEN
        libraryName(libraryValue) := nameValue ||
        libraryAddress(libraryValue) := addressValue ||
        
        newLibrary := libraryValue
    END
END
