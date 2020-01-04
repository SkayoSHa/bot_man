import React from "react";
import Loadable from "react-loadable";

const Loading = () => <div>Loading...</div>;

export const Home = Loadable({
  loader: () => import("../home"),
  loading: () => <Loading />
});
