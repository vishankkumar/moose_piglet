#
# Test the parsed function free enery Allen-Cahn Bulk kernel
#

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 20
  ny = 20
  xmin = 0
  xmax = 50
  ymin = 0
  ymax = 50
  elem_type = QUAD4

  uniform_refine = 1
[]

[GlobalParams]
  x1 = 0
  y1 = 0
  x2 = 15
  y2 = 50
  # derivative_order = 2
[]

[Variables]
  [./eta]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[ICs]
  [./eta]
    type = BoundingBoxIC
    variable = eta
    inside = 0
    outside = 1
  [../]
[]


[Kernels]
  [./detadt]
    type = ADTimeDerivative
    variable = eta
  [../]

  [./ACBulk]
    type = ADAllenCahn
    variable = eta
    f_name = F
  [../]

  [./ACInterface]
    type = ADACInterface
    variable = eta
    variable_L = false
    kappa_name = 1
  [../]
[]

[Materials]
  [./consts]
    type = ADGenericConstantMaterial
    block = 0
    prop_names  = 'L'
    prop_values = '2.5'
  [../]

  [./free_energy]
    type = ADDerivativeParsedMaterial
    block = 0
    f_name = F
    args = 'eta'
    function = '2 * eta^2 * (1-eta)^2 - 0.2*eta'
    derivative_order = 2
  [../]
[]

[Executioner]
  type = Transient
  scheme = 'bdf2'

  solve_type = 'PJFNK'

  l_max_its = 15
  l_tol = 1.0e-4

  nl_max_its = 10
  nl_rel_tol = 1.0e-11

  start_time = 0.0
  num_steps = 20
  dt = 0.5
[]

[Outputs]
  exodus = true
[]
