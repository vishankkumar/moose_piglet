[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 20
  ny = 20
  xmax = 0.7
  ymax = 0.7
[]

[GlobalParams]
  x1 = 0
  y1 = 0
  x2 = 0.2
  y2 = 0.7
[]

[Variables]
  [w]
  []
  [T]
  []
[]

[ICs]
  [wIC]
    type = SmoothCircleIC
    variable = w
    int_width = 0.1
    x1 = 0.35
    y1 = 0.35
    radius = 0.08
    outvalue = 0
    invalue = 1
  []

  #[wIC]
  #  type = BoundingBoxIC
  #  variable = w
  #  inside = 0
  #  outside = 1
  #[]

[]

[Kernels]
  [w_dot]
    type = TimeDerivative
    variable = w
  []
  [anisoACinterface1]
    type = ADACInterfaceKobayashi1
    variable = w
    mob_name = M
  []
  [anisoACinterface2]
    type = ADACInterfaceKobayashi2
    variable = w
    mob_name = M
  []
  [AllenCahn]
    type = ADAllenCahn
    variable = w
    mob_name = M
    f_name = fbulk
  []
  [T_dot]
    type = ADTimeDerivative
    variable = T
  []
  [CoefDiffusion]
    type = ADDiffusion
    variable = T
  []
  [w_dot_T]
    type = ADCoefCoupledTimeDerivative
    variable = T
    v = w
    coef = -1.8 #This is -K from kobayashis paper
  []
[]

[Materials]
  [free_energy]
    type = ADDerivativeParsedMaterial
    f_name = fbulk
    args = 'w T'
    constant_names = 'alpha gamma T_e pi'
    constant_expressions = '0.9 10 1 4*atan(1)'
    function = 'm:=alpha/pi * atan(gamma * (T_e - T)); 1/4*w^4 - (1/2 - m/3) * w^3 + (1/4 - m/2) * '
               'w^2'
    derivative_order = 1
    outputs = exodus
  []
  [material]
    type = ADInterfaceOrientationMaterial
    op = w
  []
  [consts]
    type = ADGenericConstantMaterial
    prop_names = 'M'
    prop_values = '3333.333'
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  scheme = bdf2
  automatic_scaling = true
  steady_state_detection = true
  # petsc_options = '-ksp_monitor_true_residual'
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'

  nl_rel_tol = 1e-08
  l_tol = 1e-4
  l_max_its = 30

  dt = 0.001
  num_steps = 500
[]

[Adaptivity]
  marker = error_frac
  max_h_level = 2
  [Indicators]
    [phase_jump]
      type = GradientJumpIndicator
      variable = w
      scale_by_flux_faces = true
    []
  []
  [Markers]
    [error_frac]
      type = ErrorFractionMarker
      coarsen = 0.35
      indicator = phase_jump
      refine = 0.8
    []
  []
[]

[Outputs]
  exodus = true
  console = false  
  #perf_graph = true
  #execute_on = 'INITIAL FINAL'
[]
