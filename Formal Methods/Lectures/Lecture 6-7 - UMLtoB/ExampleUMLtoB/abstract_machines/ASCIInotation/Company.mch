MACHINE
    Company
SEES
    String
SETS
    COMPANY
ABSTRACT_VARIABLES
    companies ,
    companyName
INVARIANT
    companies <: COMPANY &
    companyName : companies >-> STR
INITIALISATION
    companies , companyName := {} , {}
OPERATIONS

    newCompany <-- createCompany ( nameValue ) =
    PRE
        nameValue : STR &
        nameValue /: ran ( companyName )
    THEN
        ANY comp
        WHERE
            comp : COMPANY - companies
        THEN
            companies := companies \/ { comp } ||
            companyName ( comp ) := nameValue ||
            newCompany := comp
        END
    END ;

    nameValue <-- getCompanyName ( companyValue ) =
    PRE
        companyValue : companies
    THEN
        nameValue := companyName ( companyValue )
    END ;

    setCompanyName ( companyValue , nameValue ) =
    PRE
        companyValue : companies &
        nameValue : STR &
        nameValue /: ran ( companyName )
    THEN
        companyName ( companyValue ) := nameValue
    END ;

    removeCompany ( companyValue ) =
    PRE
        companyValue : companies
    THEN
        companies := companies - { companyValue } ||
        companyName := { companyValue } <<| companyName
    END


END
