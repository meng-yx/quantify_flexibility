library(bio3d)
library(bio3d.cna)
library(bio3d.nma)
library(igraph)
library(dplyr)


##- Singe structure NMA
## Fetch stucture
pdb <- read.pdb( "./data/AF-Q8NB16-F1-model_v6.pdb" )

## Calculate normal modes
modes <- nma(pdb)

# In this package, the first 6 modes are the trivial modes (rigid body translations and rotations)
# so the first 6 modes don't need to be considered.

## Visualization

# Create a directory to store the visualization so that it doesn't clutter the current working directory.
dir.create("NMA_bio3d", showWarnings = FALSE)
setwd("NMA_bio3d")

# Make a PDB trajectory
mode_number <- 8
mktrj(modes, mode=mode_number)    # This will write a PDB file to the current working directory.

# Vector field representation (see Figure 3.)
pymol(modes, mode=mode_number)    # This will write a R.py script to the current working directory. You can run this script to visualize the mode in PyMOL.




########################################################
# [WIP] Trying to get residue-level metrics, not sure what's the best way to do this.
########################################################


##- Function to get all mode vectors for a specific residue
get_residue_modes <- function(modes, residue_num, exclude_trivial = TRUE) {
  # Calculate the row indices for this residue (x, y, z coordinates)
  atom_indices <- ((residue_num - 1) * 3 + 1):((residue_num - 1) * 3 + 3)
  
  # Determine which modes to include
  if (exclude_trivial) {
    # Exclude the first 6 trivial modes (rigid body motions)
    mode_start <- modes$triv.modes + 1
  } else {
    mode_start <- 1
  }
  
  # Extract mode vectors for this residue across all modes
  # Result: matrix where each row is a mode, columns are x, y, z
  residue_modes <- t(modes$modes[atom_indices, mode_start:ncol(modes$modes)])
  
  # Add column names and row names
  colnames(residue_modes) <- c("x", "y", "z")
  rownames(residue_modes) <- paste0("Mode_", mode_start:ncol(modes$modes))
  
  return(residue_modes)
}

## Get all mode vectors for a specific residue
# Example: Get all modes for residue 100
residue_100_modes <- get_residue_modes(modes, residue_num = 100)


