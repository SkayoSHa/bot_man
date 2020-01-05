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

const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1
  },
  menuButton: {
    marginRight: theme.spacing(5)
  },
  environment: {
    marginRight: theme.spacing(2)
  },
  username: {
    marginRight: theme.spacing(2)
  },
  title: {
    flexGrow: 1
  },
  tabs: {
    position: "relative",
    width: "100%",
    marginLeft: theme.spacing(5),
    marginRight: theme.spacing(5)
  },
  login_logout: {
    "&:focus, &:hover, &:visited, &:link, &:active": {
      textDecoration: "none",
      backgroundColor: "inherit"
    },
    color: "white",
    marginRight: theme.spacing(1)
  }
}));

const Navigation = props => {
  const { environment, isSignedIn, username } = props;
  const path = props.location.pathname;

  const classes = useStyles();
  const [value, setValue] = React.useState(path);

  const handleChange = (_, newValue) => {
    setValue(newValue);
  };

  return (
    <div className={classes.root}>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" className={classes.title}>
            BotMan
          </Typography>

          <Tabs
            value={value}
            onChange={handleChange}
            className={classes.tabs}
            variant="scrollable"
            scrollButtons="auto"
          >
            <Tab label="Home" to="/" value="/" component={Link} />
            <Tab label="Home1" to="/home1" value="/home1" component={Link} />
            <Tab label="Home2" to="/home2" value="/home2" component={Link} />
            <Tab
              label="Home3"
              to="/home3"
              value="/home3"
              component={Link}
              disabled
            />
          </Tabs>
          <Typography variant="subtitle2" className={classes.environment}>
            {environment}
          </Typography>
          <Typography variant="subtitle2" className={classes.username}>
            {isSignedIn && `${username}`}
          </Typography>

          {isSignedIn && (
            <Button
              component={URL_Link}
              className={classes.login_logout}
              data-confirm="Sure you want to log out?"
              rel="nofollow"
              data-method="delete"
              href="/users/sign_out"
            >
              Logout
            </Button>
          )}
          {!isSignedIn && (
            <Button
              component={URL_Link}
              className={classes.login_logout}
              href="/users/sign_in"
            >
              Login
            </Button>
          )}
        </Toolbar>
      </AppBar>
    </div>
  );
};

export default withRouter(Navigation);
