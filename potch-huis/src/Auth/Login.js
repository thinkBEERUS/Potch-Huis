import { Alert, Box, Button, TextField, Slide } from "@mui/material";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import { Formik } from "formik";
import * as yup from "yup";
//import "./auth.css";
import { CssBaseline, ThemeProvider } from "@mui/material";
import { ColorModeContext, useMode, tokens } from "../theme";
import AppRegistrationIcon from "@mui/icons-material/AppRegistration";
import LockResetIcon from "@mui/icons-material/LockReset";
import LoginIcon from "@mui/icons-material/Login";

const Login = () => {
  const navigate = useNavigate();
  const [checked, setChecked] = useState(false);
  const [theme, colorMode] = useMode();
  const colors = tokens(theme.palette.mode);
  // const location = useLocation();

  // console.log(location.pathname);
  // if (location.pathname === "/" || location.pathname === "/Potch-Huis/") {
  //   const sideB = document.getElementById("sidebar");
  //   const topB = document.getElementById("topbar");
  //   sideB.hidden = true;
  //   topB.hidden = true;
  // }

  const handleRegister = () => {
    navigate("/Register");
  };

  const handleForgotPassword = () => {
    setChecked((prev) => !prev);
  };

  const handleFormSubmit = (values) => {
    const memNum = values.memberNumber;
    const password = values.password;
    const url =
      "https://localhost:7287/Members/Auth?memberNumber=" +
      memNum +
      "&password=" +
      password;
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
    })
      .then((response) => {
        console.log(response);
        navigate("/Dashboard");
      })
      .catch((error) => console.error(error));
  };

  return (
    <ColorModeContext.Provider value={colorMode}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <div
          style={{
            display: "flex",
            justifyContent: "center",
            flexDirection: "column",
            width: "100%",
            height: "100%",
            padding: "10%",
          }}
        >
          <div
            style={{
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
            }}
          >
            <h1>Potch Huis</h1>
            <Formik
              onSubmit={handleFormSubmit}
              initialValues={initialValues}
              validationSchema={checkoutSchema}
            >
              {({
                values,
                errors,
                touched,
                handleBlur,
                handleChange,
                handleSubmit,
              }) => (
                <form onSubmit={handleSubmit} style={{ width: "30%" }}>
                  <div
                    className="inputContainer"
                    style={{
                      display: "flex",
                      flexDirection: "column",
                      alignItems: "center",
                    }}
                  >
                    <TextField
                      fullWidth
                      variant="outlined"
                      type="text"
                      label="Member Number"
                      onBlur={handleBlur}
                      onChange={handleChange}
                      value={values.memberNumber}
                      name="memberNumber"
                      error={!!touched.memberNumber && !!errors.memberNumber}
                      helperText={touched.memberNumber && errors.memberNumber}
                      style={{
                        marginBottom: 10,
                        marginTop: 10,
                      }}
                      InputLabelProps={{
                        style: { textAlign: "center" },
                      }}
                    />
                    <TextField
                      fullWidth
                      variant="outlined"
                      type="Password"
                      label="Password"
                      onBlur={handleBlur}
                      onChange={handleChange}
                      value={values.Password}
                      name="Password"
                      error={!!touched.Password && !!errors.Password}
                      helperText={touched.Password && errors.Password}
                      style={{
                        marginBottom: 10,
                        marginTop: 10,
                      }}
                    />
                    <Button
                      type="submit"
                      sx={{
                        backgroundColor: colors.blueAccent[700],
                        color: colors.grey[100],
                        fontSize: "14px",
                        fontWeight: "bold",
                        padding: "10px 20px",
                        margin: "10px",
                      }}
                    >
                      <LoginIcon sx={{ mr: "10px" }} />
                      Login
                    </Button>
                  </div>
                </form>
              )}
            </Formik>
            <div
              style={{
                display: "flex",
                flexDirection: "row",
                justifyContent: "space-between",
                width: "50%",
                height: "200px",
              }}
            >
              <Button
                sx={{
                  backgroundColor: colors.primary[600],
                  color: colors.grey[100],
                  fontSize: "14px",
                  fontWeight: "bold",
                  padding: "10px 20px",
                  margin: "10px",
                }}
                onClick={handleRegister}
              >
                <AppRegistrationIcon sx={{ mr: "10px" }} />
                Register
              </Button>
              <Button
                sx={{
                  backgroundColor: colors.primary[600],
                  color: colors.grey[100],
                  fontSize: "14px",
                  fontWeight: "bold",
                  padding: "10px 20px",
                  margin: "10px",
                }}
                onClick={handleForgotPassword}
              >
                <LockResetIcon sx={{ mr: "10px" }} />
                Forgot Password
              </Button>
            </div>
          </div>
          <Box sx={{ width: `calc(200px + 100px)` }}>
            <Slide direction="right" in={checked} mountOnEnter unmountOnExit>
              <Alert>Password reset, please check your email.</Alert>
            </Slide>
          </Box>
        </div>
      </ThemeProvider>
    </ColorModeContext.Provider>
  );
};

const checkoutSchema = yup.object().shape({
  memberNumber: yup.string().required("required"),
  Password: yup.string().required("required"),
});
const initialValues = {
  memberNumber: "",
  Password: "",
};

export default Login;
