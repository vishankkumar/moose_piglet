[Mesh]
  type = GeneratedMesh # Can generate simple lines, rectangles and rectangular prisms
  dim = 2
  nx = 100
  ny = 100
  xmax = 0.001
  ymax = 0.001     
[]

[Variables]
  [pot]
    # Adds a Linear Lagrange variable by default
  []
[]

[Kernels]
  [diffusion]
    type = ADDiffusionHong  # Laplacian operator using automatic differentiation
    variable = pot # Operate on the "potential" variable from above
    diffusivity = 1e-4
    temperature = 300
  []
[]

[BCs]
  [inlet]
    type = DirichletBC  # Simple u=value BC
    variable = pot # Variable to be set
    boundary = left     # Name of a sideset in the mesh
    value = 0        # (Pa) From Figure 2 from paper.  First data point for 1mm spheres.
  []
  [outlet]
    type = DirichletBC
    variable = pot
    boundary = right
    value = 0           # (Pa) Gives the correct pressure drop from Figure 2 for 1mm spheres
  []
[]

[Materials]
  [material_constants]
    type = GenericFunctionMaterial
    #prop_names = 'temperature' 
    #prop_values = '300'
  []
[]

[Problem]
  type = FEProblem  # This is the "normal" type of Finite Element Problem in MOOSE
  # coord_type = RSPHERICAL   # Axisymmetric RZ
  #rz_coord_axis = X # Which axis the symmetry is around
  
[]

[Executioner]
  type = Steady       # Steady state problem
  solve_type = NEWTON # Perform a Newton solve, uses AD to compute Jacobian terms
  petsc_options_iname = '-pc_type -pc_hypre_type' # PETSc option pairs with values below
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  exodus = true # Output Exodus format
[]
