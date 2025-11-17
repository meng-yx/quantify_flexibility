## Proof-of-concept scripts to quantify the conformational flexibility of AF2 models for MaSIF

#### Repo structure:
- `/Bio3D`: R project using Bio3D R package to perform NMA
- `/data`: contain some example .pdb structures
- `afragmenter.ipynb`: script to split large AF2 model into independent domains, may become useful
- `NMA_prody_CA.ipynb`: NMA analysis using ProDy
- `conformation_ensemble.ipynb`: contain script to use rdkit to generate an emsemble of conformations from small molecules


**Considerations:**
- Per-residue/Per-atom score or Pairwise matrix?
- Generalisable to any molecule, not just proteins
- Directional vectors or quantitative scale?

**Potential methods:**
- Normal Mode Analysis (NMA)
- MOlecular Dynamics Simulation or Force Field
- Repacking (e.g. https://github.com/Kuhlman-Lab/PIPPack)
