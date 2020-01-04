import React from "react";
import Loadable from "react-loadable";

const Loading = () => <div>Loading...</div>;

export const BackgroundProcesses = Loadable({
  loader: () => import("../background_processes"),
  loading: () => <Loading />
});

export const Dashboard = Loadable({
  loader: () => import("../dashboard"),
  loading: () => <Loading />
});

export const DataSetPlanners = Loadable({
  loader: () => import("../data_set_planners"),
  loading: () => <Loading />
});

export const DataSetCreator = Loadable({
  loader: () => import("../data_sets/data_set_creator"),
  loading: () => <Loading />
});

export const DataSets = Loadable({
  loader: () => import("../data_sets/dashboard"),
  loading: () => <Loading />
});

export const Employers = Loadable({
  loader: () => import("../employers"),
  loading: () => <Loading />
});

export const Users = Loadable({
  loader: () => import("../users"),
  loading: () => <Loading />
});

export const RemoteDatabases = Loadable({
  loader: () => import("../remote_databases/remote_databases"),
  loading: () => <Loading />
});

export const MetaData = Loadable({
  loader: () => import("../meta_data"),
  loading: () => <Loading />
});

export const GroupNumberManager = Loadable({
  loader: () => import("../group_numbers"),
  loading: () => <Loading />
});

export const MappingConfigurations = Loadable({
  loader: () => import("../mapping_configurations"),
  loading: () => <Loading />
});

export const GlobalConfigurations = Loadable({
  loader: () => import("../global_configurations"),
  loading: () => <Loading />
});

export const GroupNumberMappings = Loadable({
  loader: () => import("../group_number_mappings"),
  loading: () => <Loading />
});

export const DataSources = Loadable({
  loader: () => import("../data_sources"),
  loading: () => <Loading />
});
