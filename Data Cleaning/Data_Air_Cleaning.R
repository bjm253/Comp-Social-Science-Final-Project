#https://catalog.data.gov/dataset/air-quality-measures-on-the-national-environmental-health-tracking-network
air_df <- read.csv("Air_Quality_Measures_on_the_National_Environmental_Health_Tracking_Networks.csv")

#Cleaning Air data set

#Removing values from air_df which I will not be using
air_df <- data.frame(MeasureName = air_df$MeasureName,
                     State = air_df$StateName,
                     ReportYear = air_df$ReportYear,
                     Value = air_df$Value)
air_df <-na.omit(air_df)

#I am choosing to only work with "Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard" to reduce the scope of my project
air_df <- air_df[grepl("Number of days with maximum 8-hour average ozone concentration over the National Ambient Air Quality Standard", air_df$MeasureName), ]

write.csv(air_df, "air_df_clean.csv", row.names = FALSE)