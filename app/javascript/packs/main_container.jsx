import React from "react";
import ReactDOM from "react-dom";
import styled from "styled-components";
import { BrowserRouter as Router } from "react-router-dom";
import Navigation from "../core/navigation";
import Pages from "../core/pages";

const Container = styled.div`
  padding: 0 20px;
`;

const MainContainer = props => {
  return (
    <Container>
      <Navigation {...props} />
      <Pages />
    </Container>
  );
};

document.addEventListener("DOMContentLoaded", () => {
  const node = document.getElementById("main-container");
  const data = JSON.parse(node.getAttribute("data"));

  ReactDOM.render(
    <Router history={history}>
      <MainContainer name="React" {...data} />
    </Router>,
    node
  );
});

export default MainContainer;
