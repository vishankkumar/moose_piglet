#include "MoosePigletApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
MoosePigletApp::validParams()
{
  InputParameters params = MooseApp::validParams();

  // Do not use legacy DirichletBC, that is, set DirichletBC default for preset = true
  params.set<bool>("use_legacy_dirichlet_bc") = false;

  return params;
}

MoosePigletApp::MoosePigletApp(InputParameters parameters) : MooseApp(parameters)
{
  MoosePigletApp::registerAll(_factory, _action_factory, _syntax);
}

MoosePigletApp::~MoosePigletApp() {}

void
MoosePigletApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAll(f, af, s);
  Registry::registerObjectsTo(f, {"MoosePigletApp"});
  Registry::registerActionsTo(af, {"MoosePigletApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
MoosePigletApp::registerApps()
{
  registerApp(MoosePigletApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
MoosePigletApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  MoosePigletApp::registerAll(f, af, s);
}
extern "C" void
MoosePigletApp__registerApps()
{
  MoosePigletApp::registerApps();
}
