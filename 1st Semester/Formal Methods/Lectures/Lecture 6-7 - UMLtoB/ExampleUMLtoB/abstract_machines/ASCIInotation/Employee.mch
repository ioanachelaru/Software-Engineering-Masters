MACHINE
    Employee
SEES
    String
USES
    Company
SETS
    EMPLOYEE ; STUDIES = { elementary , secondary , higher }
CONCRETE_CONSTANTS
    maxSalary
PROPERTIES
    maxSalary : STUDIES --> NATURAL1 &
    maxSalary = { elementary |-> 1000 , secondary |-> 2000 , higher |-> 5000 }
ABSTRACT_VARIABLES
    employees ,
    employeeId ,
    employeeName ,
    employeeSalary ,
    employeeStudies ,
    employeeEmployer
INVARIANT
     employees <: EMPLOYEE &
     employeeId : employees >-> NATURAL1 &
     employeeName : employees --> STR &
     employeeStudies : employees --> STUDIES &
     employeeSalary : employees --> NATURAL1 &
     employeeEmployer : employees --> companies &
     ! emp . ( emp : employees => employeeSalary ( emp ) <= maxSalary ( employeeStudies ( emp ) ) )
 INITIALISATION
    employees ,
    employeeId ,
    employeeName ,
    employeeSalary ,
    employeeStudies ,
    employeeEmployer := {} , {} , {} , {} , {} , {}

OPERATIONS
    newEmployee <-- createEmployee ( nameValue , studiesValue , salaryValue , companyValue ) =
    PRE
        nameValue : STR &
        studiesValue : STUDIES &
        salaryValue : NATURAL1 &
        companyValue : companies &
        salaryValue <= maxSalary ( studiesValue )
    THEN
        ANY emp
        WHERE emp : EMPLOYEE - employees
        THEN
            employees := employees \/ { emp } ||
            ANY idValue
            WHERE idValue : NATURAL1 & idValue /: ran ( employeeId )
            THEN
                employeeId ( emp ) := idValue
            END ||
            employeeName ( emp ) := nameValue ||
            employeeStudies ( emp ) := studiesValue ||
            employeeSalary ( emp ) := salaryValue ||
            employeeEmployer ( emp ) := companyValue ||
            newEmployee := emp
        END
    END ;

    setEmployeeName ( employeeValue , nameValue ) =
    PRE
        employeeValue : employees &
        nameValue : STR
    THEN
        employeeName ( employeeValue ) := nameValue
    END ;

    setEmployeeSalary ( employeeValue , salaryValue ) =
    PRE
        employeeValue : employees &
        salaryValue : NATURAL1 &
        salaryValue <= maxSalary ( employeeStudies ( employeeValue ) )
    THEN
        employeeSalary ( employeeValue ) := salaryValue
    END ;

    setEmployeeStudies ( employeeValue , studiesValue ) =
    PRE
        employeeValue : employees &
        studiesValue : STUDIES &
        employeeSalary ( employeeValue ) <= maxSalary ( studiesValue )
    THEN
        employeeStudies ( employeeValue ) := studiesValue
    END ;

    setEmployeeEmployer ( employeeValue , companyValue ) =
    PRE
        employeeValue : employees &
        companyValue : companies
    THEN
        employeeEmployer ( employeeValue ) := companyValue
    END ;

    idValue <-- getEmployeeId ( employeeValue ) =
    PRE
        employeeValue : employees
    THEN
        idValue := employeeId ( employeeValue )
    END ;

    nameValue <-- getEmployeeName ( employeeValue ) =
    PRE
        employeeValue : employees
    THEN
        nameValue := employeeName ( employeeValue )
    END ;

    studiesValue <-- getEmployeeStudies ( employeeValue ) =
    PRE
        employeeValue : employees
    THEN
        studiesValue := employeeStudies ( employeeValue )
    END ;

    salaryValue <-- getEmployeeSalary ( employeeValue ) =
    PRE
        employeeValue : employees
    THEN
        salaryValue := employeeSalary ( employeeValue )
    END ;

    companyValue <-- getEmployeeEmployer ( employeeValue ) =
    PRE
        employeeValue : employees
    THEN
        companyValue := employeeEmployer ( employeeValue )
    END ;

    deleteEmployee ( employeeValue ) =
    PRE
        employeeValue : employees
    THEN
        employees := employees - { employeeValue } ||
        employeeId :=  { employeeValue } <<| employeeId ||
        employeeName :=  { employeeValue } <<| employeeName ||
        employeeStudies :=  { employeeValue } <<| employeeStudies ||
        employeeSalary :=  { employeeValue } <<| employeeSalary ||
        employeeEmployer :=  { employeeValue } <<| employeeEmployer
    END ;

    removeAllEmployeesFromCompany ( companyValue ) =
    PRE companyValue : companies
    THEN
        employees := employees - employeeEmployer ~ [ { companyValue } ] ||
        employeeEmployer := employeeEmployer |>> { companyValue } ||
        employeeId :=  employeeEmployer ~ [ { companyValue } ] <<| employeeId ||
        employeeName :=  employeeEmployer ~ [ { companyValue } ] <<| employeeName ||
        employeeStudies :=  employeeEmployer ~ [ { companyValue } ] <<| employeeStudies ||
        employeeSalary :=  employeeEmployer ~ [ { companyValue } ] <<| employeeSalary
    END

END
