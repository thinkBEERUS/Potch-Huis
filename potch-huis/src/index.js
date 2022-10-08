import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import './index.css';
import Login from './Auth/Login';
import Register from './Auth/Register';
import Dashboard from './Home/Dashboard';
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min";
import Reports from './Reports/Reports';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <BrowserRouter basename={process.env.PUBLIC_URL}>
    <Routes>
      <Route index element={<Login />} />
      <Route path="/Potch-Huis/Login" element={<Login />} />
      <Route path="/Potch-Huis/Register" element={<Register />} />
      <Route path="/Potch-Huis/Dashboard" element={<Dashboard />} />
      <Route path="/Potch-Huis/Reports" element={<Reports />} />
    </Routes>
  </BrowserRouter>
);
