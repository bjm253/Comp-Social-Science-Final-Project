
#https://catalog.data.gov/dataset/air-quality-measures-on-the-national-environmental-health-tracking-network
air_df <- read.csv("Air_Quality_Measures_on_the_National_Environmental_Health_Tracking_Networks.csv")

unique(air_df$MeasureName)

##Cleaning Air

#Removing values from air_df which I will not be using
air_df <- data.frame(MeasureName = air_df$MeasureName,
                     State = air_df$StateName,
                     ReportYear = air_df$ReportYear,
                     Value = air_df$Value)
air_df <-na.omit(air_df)

#I decided to not use this code in my final results
#Consolidating duplicate measures
#air_df$MeasureName[grepl("(8-hour average ozone)", air_df$MeasureName)] <- "Days Exceeding NAAQ Standards"
#air_df$MeasureName[grepl("(Percent)", air_df$MeasureName)] <- "Percent of Days PM2.5 Exceeding NAAQ Standards"
#air_df$MeasureName[grepl("(Annual average)", air_df$MeasureName)] <- "Annual average ambient concentrations of PM 2.5 in micrograms per cubic meter"
#air_df$MeasureName[grepl("(erson-days with PM2.5)", air_df$MeasureName)] <- "Number of person-days with PM2.5 over the National Ambient Air Quality Standards"

#I am choosing to only work with "Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard" to reduce the scope of my project
air_df <- air_df[grepl("Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard", air_df$MeasureName), ]

#Removing all values which are equal to zero
air_df <- air_df[air_df$Value != 0, ]

write.csv(air_df, "air_df_clean.csv", row.names = FALSE)

