import React from "react";
import { Route } from "react-router-dom";
import {
  BackgroundProcesses,
  Dashboard,
  DataSetPlanners,
  DataSetCreator,
  DataSets,
  Employers,
  Users,
  RemoteDatabases,
  MetaData,
  GroupNumberManager,
  MappingConfigurations,
  GlobalConfigurations,
  GroupNumberMappings,
  DataSources
} from "./imports";

const Pages = () => (
  <>
    <Route path="/" exact component={Dashboard} />
    <Route path="/background_processes" exact component={BackgroundProcesses} />
    <Route path="/data_set_planners" exact component={DataSetPlanners} />
    <Route path="/data_set_creator" exact component={DataSetCreator} />
    <Route
      path="/data_sets/:mappingKey?/:datasetName?"
      exact
      component={DataSets}
    />
    <Route path="/employers" exact component={Employers} />
    <Route path="/meta_data" exact component={MetaData} />
    <Route path="/remote_databases" component={RemoteDatabases} />
    <Route path="/users" exact component={Users} />
    <Route path="/group_numbers" exact component={GroupNumberManager} />
    <Route
      path="/mapping_configurations"
      exact
      component={MappingConfigurations}
    />
    <Route
      path="/global_configurations"
      exact
      component={GlobalConfigurations}
    />
    <Route
      path="/group_number_mappings"
      exact
      component={GroupNumberMappings}
    />
    <Route path="/data_sources" exact component={DataSources} />
  </>
);
export default Pages;
