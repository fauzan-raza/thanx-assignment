import React from "react";
import ReactDOM from "react-dom/client";
import App from "./components/App";
import Signup from "./components/Signup";
import Login from "./components/Login";

// const root = document.getElementById("root");
// if (root) {
//   const reactRoot = ReactDOM.createRoot(root);
//   reactRoot.render(<App />);
// }

document.addEventListener("DOMContentLoaded", () => {
    const signupRoot = document.getElementById("signup-root");
    if (signupRoot) {
      const root = ReactDOM.createRoot(signupRoot);
      root.render(<Signup />);
    }
  
    const loginRoot = document.getElementById("login-root");
    if (loginRoot) {
      const root = ReactDOM.createRoot(loginRoot);
      root.render(<Login />);
    }
  });