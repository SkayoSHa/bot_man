import React from "react";
import { Route } from "react-router-dom";
import { Home } from "./imports";

const Pages = () => (
  <>
    <Route path="/" exact component={Home} />
  </>
);
export default Pages;
