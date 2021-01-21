
#pragma once

#include "ADKernelGrad.h"

class ADDiffusionHong : public ADKernelGrad
{
public:
  static InputParameters validParams();

  ADDiffusionHong(const InputParameters & parameters);

protected:
  virtual ADRealVectorValue precomputeQpResidual() override;

  const Real & _diffusivity;
  const Real & _temperature;

  // Define the universal gas constant (R) in SI units
  const double R = 8.314462618;
};
