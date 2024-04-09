#https://data.cdc.gov/NCHS/Indicators-of-Anxiety-or-Depression-Based-on-Repor/8pt5-q6wp/about_data
health_df <- read.csv("Indicators_of_Anxiety_or_Depression_Based_on_Reported_Frequency_of_Symptoms_During_Last_7_Days.csv")

#Removing values from health_df which I will not be using and dropping NA values
health_df <- data.frame(Indicator = health_df$Indicator,
                        Phase = health_df$Phase,
                        State = health_df$State,
                        TimePeriod = health_df$Time.Period.End.Date,
                        Value = health_df$Value)

health_df <- na.omit(health_df)

#Cleaning up the phases for Health so that all the variation of "3" are just "3"
health_df$Phase[grepl("(Oct|Jan|3.)", health_df$Phase)] <- "3"

#Cleaning up the phases from 4.0 to 4
health_df$Phase[grepl("(4.0)", health_df$Phase)] <- "4"

#Clean Health Year data, taking only the year from TimePeriod and moving to new column Year, same for month. Then dropping TimePeriod
health_df$Year <- substr(health_df$TimePeriod, nchar(health_df$TimePeriod) - 3, nchar(health_df$TimePeriod))
health_df$Month <- str_extract(health_df$TimePeriod, "\\d+(?=/)")
health_df$Month <- month.abb[as.integer(health_df$Month)]
health_df <- subset(health_df, select = - TimePeriod)


#Remove "United States" from the state column
health_df <- health_df[!grepl("(United States)", health_df$State), ]


unique(health_df$Indicator)

write.csv(health_df, "health_df_clean.csv", row.names = FALSE)

