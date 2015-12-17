# Summary of mlogit3_reb_3
summary(mlogit3_reb_3)
# Store table
table_s_mlogit3_reb_3 <- coef(summary(mlogit3_reb_3))
# Calculate and store p values
p_mlogit3_reb_3 <- pnorm(abs(table_s_mlogit3_reb_3["t value"]), lower.tail = FALSE) * 2
# Combine tables
table_s_mlogit3_reb_3 <- cbind(table_s_mlogit3_reb_3, "p value" = p_mlogit3_reb_3)
# Confidence Interval
ci.reb.3.3 <- confint.default(mlogit3_reb_3)
# Odds Ratios
exp(coef(mlogit3_reb_3))
# Combine Odds Ratios and Confidence Interval
exp(cbind(OR = coef(mlogit3_reb_3), ci.reb.3.3))
# Combine Odds Ratios and Confidence Interval
ORtable1.2 <- exp(cbind(OR = coef(mlogit3_reb_3), ci.reb.3.3))
# Create table
kable(ORtable1.2)
ortable1.2 <- kable(ORtable1.2, align = 'c', digits = 2)