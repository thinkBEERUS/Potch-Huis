import { Alert, Box, Button, TextField, Slide } from "@mui/material";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import { Formik } from "formik";
import * as yup from "yup";
import "./auth.css";

const Login = () => {
  const navigate = useNavigate();
  const [checked, setChecked] = useState(false);

  const handleRegister = () => {
    navigate("/Register");
  };

  const handleForgotPassword = () => {
    setChecked((prev) => !prev);
  };

  const handleFormSubmit = (values) => {
    fetch("http://localhost:3000/auth", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        username: values.memberNumber,
        password: values.Password,
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        // Check if the response contains an authentication token
        if (data.token) {
          // Create a cookie to store the token
          document.cookie = `authToken=${data.token}; path=/`;
          navigate("/Dashboard");
        }
      })
      .catch((error) => console.error(error));
  };

  return (
    <Box m="50px">
      <div
        style={{
          display: "flex",
          flexDirection: "row",
          justifyContent: "space-between",
          marginTop: "2%",
          marginLeft: "20%",
          marginRight: "20%",
          width: "60%",
        }}
      >
        <Button
          type="submit"
          variant="outlined"
          onClick={handleRegister}
          style={{
            width: "100px",
            height: "50",
            color: "#53af5b",
            borderBlockColor: "#53af5b",
            fontSize: 10,
          }}
        >
          Register
        </Button>
        <Button
          type="submit"
          variant="outlined"
          onClick={handleForgotPassword}
          style={{
            width: "100px",
            height: "50",
            color: "#53af5b",
            borderBlockColor: "#53af5b",
            fontSize: 10,
          }}
        >
          Forgot Password
        </Button>
      </div>
      <div
        style={{
          display: "flex",
          flexDirection: "row",
          justifyContent: "center",
          marginTop: "5%",
        }}
      >
        <div
          style={{
            display: "flex",
            flexDirection: "column",
            textAlign: "center",
            marginBottom: 40,
          }}
        >
          <h1 style={{ color: "#53af5b" }}>Potch Huis</h1>
          <h1 style={{ color: "#53af5b" }}>Good Times, Lekker People</h1>
        </div>
      </div>
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
          <form onSubmit={handleSubmit}>
            <div className="inputContainer">
              <TextField
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
                InputProps={{
                  sx: {
                    "& input": {
                      color: "#53af5b",
                    },
                  },
                }}
                InputLabelProps={{
                  style: { color: "#53af5b", textAlign: "center" },
                }}
              />
              <TextField
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
                InputProps={{
                  sx: {
                    "& input": {
                      color: "#53af5b",
                    },
                  },
                }}
                InputLabelProps={{
                  style: { color: "#53af5b" },
                }}
              />
              <Button
                type="submit"
                variant="outlined"
                style={{
                  marginTop: 20,
                  marginLeft: "80%",
                  width: "20%",
                  color: "#53af5b",
                  borderBlockColor: "#53af5b",
                }}
              >
                Login
              </Button>
            </div>
          </form>
        )}
      </Formik>
      <Box sx={{ height: "100%" }}>
        <Box sx={{ width: `calc(200px + 100px)` }}>
          <Slide direction="right" in={checked} mountOnEnter unmountOnExit>
            <Alert>Password reset, please check your email.</Alert>
          </Slide>
        </Box>
      </Box>
    </Box>
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
