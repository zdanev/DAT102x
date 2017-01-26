update t1 
set [Current Loan Amount] = 0 -- null?
where [Current Loan Amount] = 99999999;

update t1
set [Current Loan Amount] = (select max([Current Loan Amount]) from t1 x where x.[Loan ID] = t1.[Loan ID])
where [Current Loan Amount] is null or [Current Loan Amount] = '' or [Current Loan Amount] = 0;

update t1
set [Annual Income] = (select max([Annual Income]) from t1 x where x.[Loan ID] = t1.[Loan ID])
where [Annual Income] is null or [Annual Income] = '' or [Annual Income] = 0;

update t1
set [Credit Score] = (select max([Credit Score]) from t1 x where x.[Loan ID] = t1.[Loan ID])
where [Credit Score] is null or [Credit Score] = '' or [Credit Score] = 0;

update t1
set [Credit Score] = [Credit Score] / 10
where [Credit Score] > 1000;

update t1
set [Years in current job] = case [Years in current job]
  when 'n/a' then 0
  when '< 1 year' then 0
  when '1 year' then 1
  when '2 years' then 2
  when '3 years' then 3
  when '4 years' then 4
  when '5 years' then 5
  when '6 years' then 6
  when '7 years' then 7
  when '8 years' then 8
  when '9 years' then 9
  when '10 years' then 10
  when '10+ years' then 11
end;

update t1
set [Home Ownership] = case 
  when [Home Ownership] like '%rent%' then 'RENT' 
  when [Home Ownership] like '%own%' then 'OWN' 
  else 'MORTGAGE' 
end;

update t1
set [Purpose] = case 
  when [Purpose] like '%house%' then 'HOUSE' 
  when [Purpose] like '%car%' then 'CAR' 
  when [Purpose] like '%business%' then 'BUSINESS'
  when [Purpose] like '%debt%' then 'DEBT CONSOLIDATION'
  else 'OTHER' 
end;

update t1
set [Months since last delinquent] = 99 -- null or 0?
where [Months since last delinquent] = 'NA';

update t1
set [Bankruptcies] = 0
where [Bankruptcies] = 'NA';

select distinct
  [Loan ID],
  [Customer ID],
  [Loan Status],
  cast([Current Loan Amount] as float) as [Current Loan Amount],
  [Term],
  cast([Credit Score] as int) as [Credit Score], 
  cast([Years in current job] as int) as [Years in Current Job],
  [Home Ownership],
  cast([Annual Income] as float) as [Annual Income], 
  [Purpose],
  cast([Monthly Debt] as float) as [Monthly Debt],
  cast([Years of Credit History] as int) as [Years of Credit History],
  cast([Months since last delinquent] as int) as [Months Since Last Delinquent],
  cast([Number of Open Accounts] as int) as [Number of Open Accounts],
  cast([Number of Credit Problems] as int) as [Number of Credit Problems],
  cast([Current Credit Balance] as float) as [Current Credit Balance],
  cast([Maximum Open Credit] as float) as [Maximum Open Credit],
  cast([Bankruptcies] as int) as [Bankruptcies],
  cast([Tax Liens] as int) as [Tax Liens]
from t1;  