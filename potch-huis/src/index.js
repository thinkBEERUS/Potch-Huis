import React from 'react';
import ReactDOM from 'react-dom/client';
import { Routes, Route, HashRouter } from "react-router-dom";
import './index.css';
import Login from './Auth/Login';
import Register from './Auth/Register';
import Dashboard from './Home/Dashboard';
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min";
import Reports from './Reports/Reports';
import Members from './Members/Members';
import Menu from './Menu/Menu';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <HashRouter >
    <Routes>
      <Route index element={<Login />} />
      <Route path="Login" element={<Login />} />
      <Route path="Register" element={<Register />} />
      <Route path="Dashboard" element={<Dashboard />} />
      <Route path="Reports" element={<Reports />} />
      <Route path="Members" element={<Members />} />
      <Route path="Menu" element={<Menu />} />
    </Routes>
  </HashRouter>
);
