revenue <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)

#to calculate profit

profit<- revenue-expenses
profit

#to apply 30% tax

tax <- round(0.30*profit,digits=2)
tax

# profit after tax

pat<- profit-tax
pat

#to calculate profit margin as profit after tax over revenue

profit.margin <- round (pat / revenue,digits= 2) * 100
profit.margin

#mean of profit after tax for 12 months

mean.pat <- mean(pat)
mean.pat

# good months whose mean is > avg mean

good.months <- pat>mean.pat
good.months

#bad months whose mean is < avg mean

bad.months <- pat<mean.pat # bad.months <- !good.months
bad.months


# best month

best.month <- pat == max(pat)
best.month

# worst month

worst.month <- pat == min(pat)
worst.month

#Converting all to 1000

revenue.1000 <- round(revenue/1000,0)
expenses.1000 <- round(expenses/1000,0)
profit.1000 <- round(profit/1000,0)
pat.1000 <- round(pat/1000,0)

# Results

revenue.1000
expenses.1000
profit.1000
pat.1000
profit.margin
good.months
bad.months
best.month
worst.month
