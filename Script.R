library(readxl)

months <- c("JANUARI", "FEBRUARI", "MARET", "APRIL", "MEI", "JUNI", "JULI", "AGUSTUS", "SEPTEMBER", "OKTOBER", "NOVEMBER", "DESEMBER")

# Initialize a list to store data for each month
monthly_data <- list()

for (month in months) {
  data <- read_excel("Dataset.xlsx", sheet = month)
  monthly_data[[month]] <- table(data$`Asal Surat`)
}

# Find all unique Asal Surat across all months
Asal.surat <- unique(unlist(lapply(monthly_data, names)))

# Create the Summary data frame
Summary <- data.frame(Surat_Masuk_Tim = Asal.surat)

# Add frequency counts for each month
for (month in months) {
  month_counts <- monthly_data[[month]]
  Summary[[month]] <- as.numeric(ifelse(Asal.surat %in% names(month_counts), month_counts[match(Asal.surat, names(month_counts))], 0))
}

print(Summary)

writexl::write_xlsx(Summary,"Rekapan data.xlsx")

