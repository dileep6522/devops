select dateadd(mm,1, DATEADD(dd,1,getdate()))
/*1: Analyse the target table to establish the record attributes required 

		
			2: Search the data source(s) for a source of truth table i.e. Employee 10021 should exist in the Employees

			3: Search for remaining tables that will be used to build the source for the attributes required
			   It is easy when tables have names that appear to support the data subject but if this is not 
			   the case then more analysis is required e.g. Data Model

			4: Query the source table(s) for the subject matter to establish the subject data exists
			

			5: Any broken data ? (can this be rectified in a data fix later ? If Not then stake holder to be notified ) 

			6: Build the basic query to establish a record that will suffice to insert to the target table

			7: Test the query and establish if anything else is required to complete the query before to adding the record to the target table

			8: Create and run the INSERT script and test the success of this*/
/*
	Exercise 14.2 

	Scenario : The Hiring Manager has requested that employee 10021 is to be recorded in
			   the NEW_PAY_RUN table ready for payroll processing.

		 Tip : Use the newly created personnel record from the previous lecture
		 
			   You will need 2 correlated subqueries with a MAX() function

			   The sid_Payrun_Ref_key is the concatenation of sid_Employee and sid_Date
			   hence one of the correlated subqueries can be used to make a value for the column				 

  */
  select * from Salary_History where emp_no='10021'
  select  [sid_Employee],[current_salary]
  from [dbo].[Current_Personnel]	 where emp_no='10021'
  select cal_date from Calendar where sid_date='72830'
  select 
  [sid_Employee],[current_salary] 
  from [dbo].[Current_Personnel] cp inner join go;


  select [sid_Employee]+(select top 1 [sid_Date] from [dbo].[NEW_PAY_RUN]) as sid_payref
  from [dbo].[Current_Personnel] where sid_Employee='21'
  select * from Employees ep left join [dbo].[Current_Personnel] cp on ep.emp_no=cp.emp_no
  where cp.sid_Employee is null

  select [sid_Employee],[emp_no] from [dbo].[Employees] where emp_no='15675'
  select [current_salary] from Salary_History where emp_no='15675'
  select [City] from [dbo].[Employee_Location] where emp_no='15675'
  
  select sid_Department from [dbo].[Employee_Movements_History] where emp_no='15675'
  select [sid_Location] from [dbo].[Geography] where  City='Sydney'
  select sid_Position from [dbo].[Employee_Position_History] where emp_no='15675'
   
   insert into Current_Personnel([sid_Employee],[emp_no],[current_salary],[current_location],[sid_Department],[sid_Location],[sid_position])
  select ep.[sid_Employee],ep.[emp_no],sh.current_salary,el.City,emh.sid_Department,g.sid_Location,eph.sid_Position
  from [dbo].[Employees] ep inner join Salary_History sh on ep.emp_no=sh.emp_no
        inner join Employee_Location el on el.emp_no=ep.emp_no inner join Employee_Movements_History emh on emh.emp_no=ep.emp_no
		inner join Employee_Position_History eph on eph.emp_no=ep.emp_no inner join Geography g on g.City=el.City
		where ep.emp_no='15675'

		select * from [dbo].[Current_Personnel] where emp_no='15675'

		select top 5 * from [dbo].[NEW_PAY_RUN]
		insert into [dbo].[NEW_PAY_RUN] ([sid_Payrun_Ref_Key],[sid_Employee],[Pay_Amount],[paydate],[sid_Date])
		 select 
	concat([sid_Employee],(select top 1sid_date from NEW_PAY_RUN)) as sid_Payrun_Ref_Key , 
		 sid_Employee,
		 [current_salary]/12 as pay_Amount,
		(select top 1 paydate from NEW_PAY_RUN )as paydate,
		(select top 1 sid_date from NEW_PAY_RUN) as sid_date
		from Current_Personnel 
		where sid_Employee='6701'
		select * from NEW_PAY_RUN where 
		sid_Employee='6701'