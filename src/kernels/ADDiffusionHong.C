
#include "ADDiffusionHong.h"

registerMooseObject("MoosePigletApp", ADDiffusionHong);

InputParameters
ADDiffusionHong::validParams()
{
  auto params = ADKernelGrad::validParams();
  params.addClassDescription("Modified diffusion kernel defined in Hong2018 paper and "
                             "is computed using forward automatic differentiation");
  params.addParam<Real>("temperature", 300, "Temperature of simulation in K");
  params.addRequiredParam<Real>("diffusivity", "Diffusivity of Lithium ions in cm2/sec");
  return params;
}

ADDiffusionHong::ADDiffusionHong(const InputParameters & parameters) : ADKernelGrad(parameters),
  // Get the temperature and diffusion coefficient of Li ions
  _diffusivity(getParam<Real>("diffusivity")),
  _temperature(getParam<Real>("temperature"))
  {}

ADRealVectorValue
ADDiffusionHong::precomputeQpResidual()
{
  return _diffusivity * _grad_u[_qp] / ( R *  _temperature);

}
