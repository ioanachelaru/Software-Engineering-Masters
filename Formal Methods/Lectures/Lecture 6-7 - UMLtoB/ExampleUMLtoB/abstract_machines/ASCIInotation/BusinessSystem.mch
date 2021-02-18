MACHINE
    BusinessSystem
INCLUDES
    Employee , Company
PROMOTES
    createCompany , getCompanyName , setCompanyName ,
    createEmployee , deleteEmployee ,
    getEmployeeId , getEmployeeName , getEmployeeSalary , getEmployeeStudies , getEmployeeEmployer ,
    setEmployeeName , setEmployeeSalary , setEmployeeStudies , setEmployeeEmployer
OPERATIONS

    deleteCompany ( companyValue ) =
    PRE companyValue : companies
    THEN
        removeCompany ( companyValue ) ||
        removeAllEmployeesFromCompany ( companyValue )
    END


END
