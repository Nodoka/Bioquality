source('../library/sanitise_data.R')
# use excle_cell
source('../bin/manipulate_bexcl_cell_pref.R')

# load data
species_cell   <- read.csv('../data/species_cell.csv', row.names = NULL)

# filter valid stars for chosen star column
species_cell   <- filter_rows_by_valid_star(species_cell,'star_infs')

# remove moss species (horim_page = 471~500)
# uncomment to include moss sp
not_moss <- subset(species_cell, horim_page <471 | horim_page>500) 
species_cell <- not_moss

# merge cell and species
excl_sp <- merge(excl_cell, species_cell)

# filter relevant columns
excl_sp <- t[,c("sampname","prefno","scode","spnumber","star_infs")]

# unique sort species
uniq_exclsp <- unique(excl_sp[,c("spnumber", "star_infs")])

# tabulate star_infs statistics
stars <- table(uniq_exclsp$star_infs)

