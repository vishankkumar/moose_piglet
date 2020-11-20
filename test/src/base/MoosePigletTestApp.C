//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "MoosePigletTestApp.h"
#include "MoosePigletApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"
#include "ModulesApp.h"

InputParameters
MoosePigletTestApp::validParams()
{
  InputParameters params = MoosePigletApp::validParams();
  return params;
}

MoosePigletTestApp::MoosePigletTestApp(InputParameters parameters) : MooseApp(parameters)
{
  MoosePigletTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

MoosePigletTestApp::~MoosePigletTestApp() {}

void
MoosePigletTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  MoosePigletApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"MoosePigletTestApp"});
    Registry::registerActionsTo(af, {"MoosePigletTestApp"});
  }
}

void
MoosePigletTestApp::registerApps()
{
  registerApp(MoosePigletApp);
  registerApp(MoosePigletTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
MoosePigletTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  MoosePigletTestApp::registerAll(f, af, s);
}
extern "C" void
MoosePigletTestApp__registerApps()
{
  MoosePigletTestApp::registerApps();
}
