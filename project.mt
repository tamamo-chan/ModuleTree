Seasons ( 
	Decisions: accept, reject, maybe(get_more_credit, customer_account_age_too_low, recommend_reject, unsure)

	Input: int credit, int number_accounts, bool previous_loans, int account_age, bool CEO
	
	Parameters:
	good=0
	bad = 0
	
	Rules:
	if credit > 1000 + 5000? add 50 to good  
	if credit > 5000? add 6 to good  
	if previous_loans? conclude reject  
	if credit <= 199? sub 10 from good
	if account_age < 5? add 10 to bad
	if number_accounts > 3? add 10 to good
	if 10000 < credit? add 30 to good          
	if CEO? conclude accept
	
	Conclusion:       
	if good > 70: conclude accept    
	if 20 > good: conclude reject      
	if good <= bad: conclude reject    
	if maybe(
	if good > 55: conclude get_more_credit
	if good < 45: conclude recommend_reject
	if bad > 0: conclude recommend_reject
	else: unsure           
	)       	 
)
Summer extends Seasons (
	Decisions: tester, multi(too_hot, too_windy, dec3)
	
	Input: int temperature, int wind, string weather, string rainy
	 
	Parameters:
	good = 5    
	sun=0
	wind=0
	
	Rules: 
	if wind > 30? add 30 to wind
	if temperature > 30? add 30 to sun
	if weather == rainy? sub 20 from sun
	if temperature > 30? add 30 to good  
	if 10 > wind? conclude tester  
	
	Conclusion:
	if test > 0: conclude yes    
)
