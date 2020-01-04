import React from "react";
import ReactDOM from "react-dom";
import PropTypes from "prop-types";

const MainContainer = props => <div>Hello12 {props.name}!</div>;

MainContainer.defaultProps = {
  name: "David"
};

MainContainer.propTypes = {
  name: PropTypes.string
};

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <MainContainer name="React" />,
    document
      .getElementById("main-container")
      .appendChild(document.createElement("div"))
  );
});
