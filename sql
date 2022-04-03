# use wind;
# select * from users where age in(20,25,30);

# select * from client where length(FirstName)<6;
# select * from client where City = 'Lviv';
# select * from client where Education = 'high' order by LastName;
# select * from application order by idApplication desc limit 5;
# select * from client where LastName like '%iv' or LastName like '%iva';

# select * from client
# join department d on d.idDepartment = client.Department_idDepartment
# where DepartmentCity = 'Kyiv';

# select * from client
# join department d on d.idDepartment = client.Department_idDepartment
# join application a on client.idClient = a.Client_idClient
# where Sum > 5000 and Currency = 'Gryvnia';

# select COUNT(*) as count, DepartmentCity from client
# join department d on d.idDepartment = client.Department_idDepartment
# where DepartmentCity = 'Lviv' group by DepartmentCity
# Union
# select count(*) as CountAll, null from client;

#resolve
# select COUNT(*), idDepartment, DepartmentCity from client
# join department d on d.idDepartment = client.Department_idDepartment
# group by idDepartment, DepartmentCity;

# select max(Sum) as maxApplication, Client_idClient from application
# join client c on c.idClient = application.Client_idClient
# group by Client_idClient order by Client_idClient;

# select COUNT(Client_idClient) as count, Client_idClient from application
# group by Client_idClient order by Client_idClient;

# select max(Sum) as maxSum from application
# Union
# select min(Sum) as minSum from application;

#resolve
# select max(Sum) as maxSum, min(Sum) as minSum from application;

# select count(*) as count, Education from application
# join client c on c.idClient = application.Client_idClient
# where Education = 'high'
# group by Education order by count;

# select avg(Sum) as avg, Client_idClient as cID, FirstName, LastName from application
# join client c on c.idClient = application.Client_idClient
# group by cID, FirstName, LastName order by avg desc limit 1;

# select sum(Sum) as sum, idDepartment, DepartmentCity from application
# join client c on c.idClient = application.Client_idClient
# join department d on d.idDepartment = c.Department_idDepartment
# group by idDepartment, DepartmentCity order by sum desc limit 1;

# select max(Sum) as maxSum, idDepartment, DepartmentCity from application
# join client c on c.idClient = application.Client_idClient
# join department d on d.idDepartment = c.Department_idDepartment
# group by idDepartment, DepartmentCity order by maxSum desc limit 1;

#17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
# update application
# join client c on c.idClient = application.Client_idClient
# set Sum = 6000
# where Education = 'high';

# #18. Усіх клієнтів київських відділень пересилити до Києва.
# update client
# join department d on d.idDepartment = client.Department_idDepartment
# set City = 'Kyiv'
# where DepartmentCity = 'Kyiv';

#19. Видалити усі кредити, які є повернені.
# update application set Sum = null where CreditState = 'Returned';

#20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
#resolve - delete application
# update application
# join client c on c.idClient = application.Client_idClient
# set Sum = null
# where LastName like '_a%' or LastName like '_e%' or LastName like '_u%' or LastName like '_o%' or LastName like '_i%';

#21.Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000

# select sum(Sum) as sum, DepartmentCity, Department_idDepartment from application
# join client c on c.idClient = application.Client_idClient
# join department d on d.idDepartment = c.Department_idDepartment
# where sum > 5000 and DepartmentCity = 'Lviv' group by DepartmentCity, Department_idDepartment order by sum;

# 22.Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000

# select Sum, CreditState, LastName, FirstName from application
# join client c on c.idClient = application.Client_idClient
# where Sum>5000 and CreditState='Returned' group by Sum, CreditState, LastName, FirstName;

# 23.Знайти максимальний неповернений кредит.

# select max(Sum) from application where CreditState = 'Not returned';

# 24.Знайти клієнта, сума кредиту якого найменша

# select min(Sum) as min, LastName, FirstName  from application
# join client c on c.idClient = application.Client_idClient
# group by LastName, FirstName limit 1;

# 25.Знайти кредити, сума яких більша за середнє значення усіх кредитів

# select Sum, Client_idClient from application where Sum>(select avg(Sum) as avg from application) group by Sum, Client_idClient;

# 26. Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів
# select idClient,LastName, FirstName, City from client
# where City =(select City from client
# join application a on client.idClient = a.Client_idClient
# group by idClient order by count(*) desc limit 1)
# group by LastName, idClient, FirstName, City;

#27. Місто клієнта з найбільшою кількістю кредитів

# select max(Sum) as max, City, Client_idClient from application
# join client c on c.idClient = application.Client_idClient
# group by City, Client_idClient order by max desc limit 1;

#resolve
# select City from client
# join application a on client.idClient = a.Client_idClient
# group by idClient
# order by count(*) desc limit 1;
