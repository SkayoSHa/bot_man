import AppBar from "@material-ui/core/AppBar";
import Button from "@material-ui/core/Button";
import { default as URL_Link } from "@material-ui/core/Link";
import { makeStyles } from "@material-ui/core/styles";
import Tab from "@material-ui/core/Tab";
import Tabs from "@material-ui/core/Tabs";
import Toolbar from "@material-ui/core/Toolbar";
import Typography from "@material-ui/core/Typography";
import React from "react";
import { Link, withRouter } from "react-router-dom";
import styled from "styled-components";

const Root = styled.div`
  flex-grow: 1;
`;

const EnvironmentLabel = styled(Typography)`
  margin-right: 16px !important;
`;

const UsernameLabel = styled(Typography)`
  margin-right: 16px !important;
`;

const Title = styled(Typography)`
  flex-grow: 1;
`;

const TopTabs = styled(Tabs)`
  position: relative;
  width: 100%;
  margin-left: 16px;
  margin-right: 16px;
`;

const LogoutButton = styled(Button)`
  &:focus,
  &:hover,
  &:visited,
  &:link,
  &:active {
    text-decoration: none !important;
    background-color: inherit;
    color: white;
  }
  color: white;
  margin-right: 16px;
`;

const LoginButton = styled(LogoutButton)``;

const Navigation = props => {
  const { environment, isSignedIn, username } = props;
  const path = props.location.pathname;

  const [value, setValue] = React.useState(path);

  const handleChange = (_, newValue) => {
    setValue(newValue);
  };

  return (
    <Root>
      <AppBar position="static">
        <Toolbar>
          <Title variant="h6">BotMan</Title>

          <TopTabs
            value={value}
            onChange={handleChange}
            variant="scrollable"
            scrollButtons="auto"
          >
            <Tab label="Home" to="/" value="/" component={Link} />
            <Tab label="Home1" to="/home1" value="/home1" component={Link} />
            <Tab
              label="Home2"
              to="/home2"
              value="/home2"
              component={Link}
              disabled
            />
            <Tab label="Home3" to="/home3" value="/home3" component={Link} />
          </TopTabs>
          <EnvironmentLabel variant="subtitle2">{environment}</EnvironmentLabel>
          <UsernameLabel variant="subtitle2">
            {isSignedIn && `${username}`}
          </UsernameLabel>

          {isSignedIn && (
            <LogoutButton
              component={URL_Link}
              data-confirm="Sure you want to log out?"
              rel="nofollow"
              data-method="delete"
              href="/users/sign_out"
            >
              Logout
            </LogoutButton>
          )}
          {!isSignedIn && (
            <LoginButton component={URL_Link} href="/users/sign_in">
              Login
            </LoginButton>
          )}
        </Toolbar>
      </AppBar>
    </Root>
  );
};

export default withRouter(Navigation);
