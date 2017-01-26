select *,
	[Current Loan Amount] / [Annual Income] as [Loan to Income Ratio],
	[Monthly Debt] / [Annual Income] * 12  as [Debt to Income Ratio],
	[Current Credit Balance] / [Annual Income] as [Credit Ballance to Income Ratio],
	[Current Credit Balance] / [Maximum Open Credit] as [Credit Ballance to Credit Ratio],
	case when [Credit Score] < 500 then 'No' else 'Yes' end as [CS500],
	case when [Credit Score] < 550 then 'No' else 'Yes' end as [CS550],
	case when [Credit Score] < 600 then 'No' else 'Yes' end as [CS600],
	case when [Credit Score] < 650 then 'No' else 'Yes' end as [CS650],
	case when [Credit Score] < 700 then 'No' else 'Yes' end as [CS700],
	case when [Credit Score] < 750 then 'No' else 'Yes' end as [CS750],
	case when [Years in Current Job] = 0 then 'Yes' else 'No' end as [Unemployed],
	case when [Years in Current Job] = 0
		OR [Number of Credit Problems] > 1 
		OR [Months Since Last Delinquent] < 12
		OR [Bankruptcies] > 0
		OR [Tax Liens] > 0
		then 'Yes' else 'No' 
	end as [Risky]
from t1;